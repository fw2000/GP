Fs = 25; %in Hz
d = designfilt('bandstopiir', 'FilterOrder', 10, 'HalfPowerFrequency1', 0.1, 'HalfPowerFrequency2', 0.4, 'SampleRate', Fs );

signal = readmatrix('1R10edit.csv');
v1 = signal(:,1);
v2 = signal(:,2);
v3 = signal(:,3);
v4 = signal(:,4);
v5 = signal(:,5);
v6 = signal(:,6);
v7 = signal(:,7);
v8 = signal(:,8);
v9 = signal(:,9);
v10 = signal(:,10);
v11 = signal(:,11);
v12 = signal(:,12);
time = signal(:,13);

filteredsignal1 = filtfilt(d,v1);
filteredsignal2 = filtfilt(d,v2);
filteredsignal3 = filtfilt(d,v3);
filteredsignal4 = filtfilt(d,v4);
filteredsignal5 = filtfilt(d,v5);
filteredsignal6 = filtfilt(d,v6);
filteredsignal7 = filtfilt(d,v7);
filteredsignal8 = filtfilt(d,v8);
filteredsignal9 = filtfilt(d,v9);
filteredsignal10 = filtfilt(d,v10);
filteredsignal11= filtfilt(d,v11);
filteredsignal12= filtfilt(d,v12);
averageFiltered = (filteredsignal1+filteredsignal2+filteredsignal3+filteredsignal4+filteredsignal5+filteredsignal6+filteredsignal7+filteredsignal8+filteredsignal9+filteredsignal10+filteredsignal11+filteredsignal12)/12;
average= (v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12)/12;
plot(time, average, time, averageFiltered);
drawnow
result = [filteredsignal1,filteredsignal2,filteredsignal3,filteredsignal4,filteredsignal5, filteredsignal6, filteredsignal7,filteredsignal8,filteredsignal9,filteredsignal10,filteredsignal11,filteredsignal12, time];
writematrix(result, 'result1R10edit.csv');
