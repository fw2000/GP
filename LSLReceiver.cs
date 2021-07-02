using UnityEngine;
using LSL;
using System;

public class LSLReceiver : MonoBehaviour
{
    private enum StreamIdentifier
    {
        name,
        type
    }

    [SerializeField, Tooltip("Content type of the stream. Please see https://github.com/sccn/xdf/wiki/Meta-Data")]
    string StreamType = "EEG";
    [SerializeField, Tooltip("Name of the stream. Describes the device (or product series) that this stream makes available.")]
    string StreamName;
    [SerializeField, Tooltip("Number of minimum streams."), Range(1, 10)]
    int numberOfMinStreams = 1;
    [SerializeField, Tooltip("Timeout")]
    float timeOut = 0.0f;
    [SerializeField, Tooltip("Identifier to search for outlet streams in the local network. Either name or type of the outlet.")]
    StreamIdentifier streamIdentifier = StreamIdentifier.type;

    public static event Action<float> ReceivedNewDataFloat;
    public static event Action<float[]> ReceivedNewDataFloatList;
    public static event Action<int> ReceivedNewDataInt;
    public static event Action<int[]> ReceivedNewDataIntList;
    private int channelCount = 0;
    private channel_format_t format;

    private bool IsStreamInletEmpty => streamInlet == null;
    private StreamInfo[] streamInfos;
    private StreamInlet streamInlet;


    private void Update()
    {
        if (IsStreamInletEmpty)
        {
            resolveNewStream();
        }
        if (!IsStreamInletEmpty)
        {
            FillSamples();
        }
    }

    private void FillSamples()
    {
        float[] sample = new float[channelCount];
        double lastTimeStamp = streamInlet.pull_sample(sample, 0.0f);
        if (lastTimeStamp != 0.0)
        {
            //Debug.Log("Sample: " + sample[0] + " Last Time Stamp: " + lastTimeStamp);
            NotifySubscribers(sample);
            while ((streamInlet.pull_sample(sample, 0.0f)) != 0)
            {
                //Debug.Log("Sample: " + sample[0] + "Last Time Stamp: " + lastTimeStamp);
                NotifySubscribers(sample);
            }
        }

    }

    private void NotifySubscribers(float[] sample)
    {
        int[] intSample = GetIntegerValues(sample);
        
        ReceivedNewDataFloatList?.Invoke(sample);
        ReceivedNewDataIntList?.Invoke(intSample);
        ReceivedNewDataFloat?.Invoke(sample[0]);
        ReceivedNewDataInt?.Invoke(intSample[0]);
    }



    private void resolveNewStream()
    {
        string identifier = streamIdentifier.ToString() == "type" ? StreamType : StreamName;
        streamInfos = LSL.LSL.resolve_stream(streamIdentifier.ToString(), identifier, numberOfMinStreams, timeOut);
        
        if (streamInfos.Length > 0)
        {
            InitilzeStreamInlet();
        }
    }
    private void InitilzeStreamInlet()
    {
        Debug.Log("New Stream found...");
        streamInlet = new StreamInlet(streamInfos[0]);
        channelCount = streamInlet.info().channel_count();
        format = streamInlet.info().channel_format();
        streamInlet.open_stream();
        ShowChannelInfo();
    }
    private void ShowChannelInfo()
    {
        Debug.Log("Stream Name: " + streamInlet.info().name());
        Debug.Log("Stream type: " + streamInlet.info().type());
        Debug.Log("Stream source id: " + streamInlet.info().source_id());
        Debug.Log("Channel count: " + channelCount);
        Debug.Log("Channel count: " + format.ToString());
    }
    private int[] GetIntegerValues(float[] vals)
    {
        int [] integerValues = new int[vals.Length];
        for (int i = 0; i < vals.Length; i++)
        {
            integerValues[i] = Mathf.RoundToInt(vals[i]);
        }
        return integerValues;
    }
}
