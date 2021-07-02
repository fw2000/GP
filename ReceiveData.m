%% instantiate the library
disp('Loading the library...');
lib = lsl_loadlib();

% resolve a stream...
disp('Resolving an NIRS stream...');
result = {};

% make a new stream outlet
disp('Creating a new streaminfo...');
info = lsl_streaminfo(lib,'MATLAB','state',8,100,'cf_float32','sdfwerr32432');

disp('Opening an outlet...');
outlet = lsl_outlet(info);
%tline = 0;
while isempty(result)
    result = lsl_resolve_byprop(lib,'type','NIRS'); end

% create a new inlet
disp('Opening an inlet...');
inlet = lsl_inlet(result{1});

disp('Now receiving data...');
firstValue = true;
sample = false;
BCI = false;
setup = true;
nsamples = 750; %samples taken = sample freq (50)* seconds(15)
nsamples2 = 1500; %samples taken = sample freq (50)* seconds(30)
bltime = zeros(1,nsamples);
b_average_R = 0;
b_average_L = 0;
Rx1Tx1Osample = zeros(1,nsamples);
Rx1Tx1Hsample = zeros(1,nsamples);
Rx1Tx2Osample = zeros(1,nsamples);
Rx1Tx2Hsample = zeros(1,nsamples);
Rx1Tx3Osample = zeros(1,nsamples);
Rx1Tx3Hsample = zeros(1,nsamples);
Rx2Tx1Osample = zeros(1,nsamples);
Rx2Tx1Hsample = zeros(1,nsamples);
Rx2Tx3Osample = zeros(1,nsamples);
Rx2Tx3Hsample = zeros(1,nsamples);
Rx2Tx4Osample = zeros(1,nsamples);
Rx2Tx4Hsample = zeros(1,nsamples);
Rx3Tx2Osample = zeros(1,nsamples);
Rx3Tx2Hsample = zeros(1,nsamples);
Rx3Tx3Osample = zeros(1,nsamples);
Rx3Tx3Hsample = zeros(1,nsamples);
Rx4Tx3Osample = zeros(1,nsamples);
Rx4Tx3Hsample = zeros(1,nsamples);
Rx4Tx4Osample = zeros(1,nsamples);
Rx4Tx4Hsample = zeros(1,nsamples);
Rx3Tx5Osample = zeros(1,nsamples);
Rx3Tx5Hsample = zeros(1,nsamples);
Rx4Tx5Osample = zeros(1,nsamples);
Rx4Tx5Hsample = zeros(1,nsamples);
Rx5Tx7Osample = zeros(1,nsamples);
Rx5Tx7Hsample = zeros(1,nsamples);
Rx5Tx6Osample = zeros(1,nsamples);
Rx5Tx6Hsample = zeros(1,nsamples);
Rx5Tx8Osample = zeros(1,nsamples);
Rx5Tx8Hsample = zeros(1,nsamples);
Rx7Tx7Osample = zeros(1,nsamples);
Rx7Tx7Hsample = zeros(1,nsamples);
Rx7Tx8Osample = zeros(1,nsamples);
Rx7Tx8Hsample = zeros(1,nsamples);
Rx7Tx10Osample = zeros(1,nsamples);
Rx7Tx10Hsample = zeros(1,nsamples);
Rx6Tx6Osample = zeros(1,nsamples);
Rx6Tx6Hsample = zeros(1,nsamples);
Rx6Tx8Osample = zeros(1,nsamples);
Rx6Tx8Hsample = zeros(1,nsamples);
Rx8Tx8Osample = zeros(1,nsamples);
Rx8Tx8Hsample = zeros(1,nsamples);
Rx8Tx10Osample = zeros(1,nsamples);
Rx8Tx10Hsample = zeros(1,nsamples);
Rx6Tx9Osample = zeros(1,nsamples);
Rx6Tx9Hsample = zeros(1,nsamples);
Rx8Tx9Osample = zeros(1,nsamples);
Rx8Tx9Hsample = zeros(1,nsamples);

average_R = 0;
average_L = 0;
bcitime = zeros(1,nsamples2);
Rx1Tx1OBCI = zeros(1,nsamples2);
Rx1Tx1HBCI = zeros(1,nsamples2);
Rx1Tx2OBCI = zeros(1,nsamples2);
Rx1Tx2HBCI = zeros(1,nsamples2);
Rx1Tx3OBCI = zeros(1,nsamples2);
Rx1Tx3HBCI = zeros(1,nsamples2);
Rx2Tx1OBCI = zeros(1,nsamples2);
Rx2Tx1HBCI = zeros(1,nsamples2);
Rx2Tx3OBCI = zeros(1,nsamples2);
Rx2Tx3HBCI = zeros(1,nsamples2);
Rx2Tx4OBCI = zeros(1,nsamples2);
Rx2Tx4HBCI = zeros(1,nsamples2);
Rx3Tx2OBCI = zeros(1,nsamples2);
Rx3Tx2HBCI = zeros(1,nsamples2);
Rx3Tx3OBCI = zeros(1,nsamples2);
Rx3Tx3HBCI = zeros(1,nsamples2);
Rx4Tx3OBCI = zeros(1,nsamples2);
Rx4Tx3HBCI = zeros(1,nsamples2);
Rx4Tx4OBCI = zeros(1,nsamples2);
Rx4Tx4HBCI = zeros(1,nsamples2);
Rx3Tx5OBCI = zeros(1,nsamples2);
Rx3Tx5HBCI = zeros(1,nsamples2);
Rx4Tx5OBCI = zeros(1,nsamples2);
Rx4Tx5HBCI = zeros(1,nsamples2);
Rx5Tx7OBCI = zeros(1,nsamples2);
Rx5Tx7HBCI = zeros(1,nsamples2);
Rx5Tx6OBCI = zeros(1,nsamples2);
Rx5Tx6HBCI = zeros(1,nsamples2);
Rx5Tx8OBCI = zeros(1,nsamples2);
Rx5Tx8HBCI = zeros(1,nsamples2);
Rx7Tx7OBCI = zeros(1,nsamples2);
Rx7Tx7HBCI = zeros(1,nsamples2);
Rx7Tx8OBCI = zeros(1,nsamples2);
Rx7Tx8HBCI = zeros(1,nsamples2);
Rx7Tx10OBCI = zeros(1,nsamples2);
Rx7Tx10HBCI = zeros(1,nsamples2);
Rx6Tx6OBCI = zeros(1,nsamples2);
Rx6Tx6HBCI = zeros(1,nsamples2);
Rx6Tx8OBCI = zeros(1,nsamples2);
Rx6Tx8HBCI = zeros(1,nsamples2);
Rx8Tx8OBCI = zeros(1,nsamples2);
Rx8Tx8HBCI = zeros(1,nsamples2);
Rx8Tx10OBCI = zeros(1,nsamples2);
Rx8Tx10HBCI = zeros(1,nsamples2);
Rx6Tx9OBCI = zeros(1,nsamples2);
Rx6Tx9HBCI = zeros(1,nsamples2);
Rx8Tx9OBCI = zeros(1,nsamples2);
Rx8Tx9HBCI = zeros(1,nsamples2);

time = [];
n = 1;
p = 1;
new = true;
%fileID = fopen('test1.txt', 'w');
sampleFile = fopen('baseline.txt', 'w');
windowsize = 200;
Fs = 50; %50 hz
d = designfilt('bandpassiir', 'FilterOrder', 4, 'HalfPowerFrequency1', 0.1, 'HalfPowerFrequency2', 0.5, 'SampleRate', Fs );

while true
    % get data from the inlet
    [vec,ts] = inlet.pull_sample();
    %Send Data to Unity/

    %disp(output);
    %reset time to 0
    if firstValue
        ts1 = ts;
        %disp(ts1);
        firstValue = false;
    end
    time = ts - ts1;
    %save the data to text file
    %fprintf(fileID,'%.2f\t',vec);
    %fprintf(fileID,'%.5f\n',time);
    
    %display choices to 
    if setup
        prompt = 'What do you want to do: record baseline (b), start BCI (s)';
        str = input(prompt, 's');
        if str == 'b'
            sample = true;
            setup = false; 
        elseif str == 's'
            BCI = true;
            setup = false;            
        end
    end
    
    % record a baseline sample of nsamples length
    if sample && (n <= nsamples)
        bltime(n) = time;
        Rx1Tx1Osample(n) = vec(1);
        %Rx1Tx1Hsample(n) = vec(2);
        Rx1Tx2Osample(n) = vec(3);
        %Rx1Tx2Hsample(n) = vec(4);
        Rx1Tx3Osample(n) = vec(5);
        %Rx1Tx3Hsample(n) = vec(6);
        Rx2Tx1Osample(n) = vec(7);
        %Rx2Tx1Hsample(n) = vec(8);
        Rx2Tx3Osample(n) = vec(9);
        %Rx2Tx3Hsample(n) = vec(10);
        Rx2Tx4Osample(n) = vec(11);
        %Rx2Tx4Hsample(n) = vec(12);
        Rx3Tx2Osample(n) = vec(13);
        %Rx3Tx2Hsample(n) = vec(14);
        Rx3Tx3Osample(n) = vec(15);
        %Rx3Tx3Hsample(n) = vec(16);
        Rx4Tx3Osample(n) = vec(17);
        %Rx4Tx3Hsample(n) = vec(18);
        Rx4Tx4Osample(n) = vec(19);
        %Rx4Tx4Hsample(n) = vec(20);
        Rx3Tx5Osample(n) = vec(21);
        %Rx3Tx5Hsample(n) = vec(22);
        Rx4Tx5Osample(n) = vec(23);
        %Rx4Tx5Hsample(n) = vec(24);
        Rx5Tx7Osample(n) = vec(25);
        %Rx5Tx7Hsample(n) = vec(26);
        Rx5Tx6Osample(n) = vec(27);
        %Rx5Tx6Hsample(n) = vec(28);
        Rx5Tx8Osample(n) = vec(29);
        %Rx5Tx8Hsample(n) = vec(30);
        Rx7Tx7Osample(n) = vec(31);
        %Rx7Tx7Hsample(n) = vec(32);
        Rx7Tx8Osample(n) = vec(33);
        %Rx7Tx8Hsample(n) = vec(34);
        Rx7Tx10Osample(n) = vec(35);
        %Rx7Tx10Hsample(n) = vec(36);
        Rx6Tx6Osample(n) = vec(37);
        %Rx6Tx6Hsample(n) = vec(38);
        Rx6Tx8Osample(n) = vec(39);
        %Rx6Tx8Hsample(n) = vec(40);
        Rx8Tx8Osample(n) = vec(41);
        %Rx8Tx8Hsample(n) = vec(42);
        Rx8Tx10Osample(n) = vec(43);
        %Rx8Tx10Hsample(n) = vec(44);
        Rx6Tx9Osample(n) = vec(45);
        %Rx6Tx9Hsample(n) = vec(46);
        Rx8Tx9Osample(n) = vec(47);
        %Rx8Tx9Hsample(n) = vec(48);
        %save baseline to file
        fprintf(sampleFile,'%.2f\t',vec);
        fprintf(sampleFile,'%.2f\n',time);
        n = n+1;
    elseif sample
        disp('HELLOOOOOOOO');
        filteredRx6Tx6Osample = filtfilt(d,Rx6Tx6Osample);
        figure(1);
        plot(bltime, filteredRx6Tx6Osample,' r' ,  bltime, Rx6Tx6Osample,'b');
        drawnow 
        %disp(Rx1Tx1Osample);
        %mean1 = mean(Rx1Tx1Osample);
        %mean2 = mean(Rx1Tx1Hsample);
        %mean3 = mean(Rx1Tx2Osample);
        b_average_R = (mean(Rx1Tx1Osample)+ mean(Rx1Tx2Osample)+ mean(Rx1Tx3Osample) + mean(Rx2Tx1Osample) + mean(Rx3Tx2Osample)+ mean(Rx4Tx3Osample) +mean(Rx3Tx5Osample) + mean(Rx4Tx5Osample)+ mean( Rx2Tx4OBCI) + mean(Rx3Tx3OBCI) + mean( Rx4Tx4OBCI)+ mean( Rx2Tx3OBCI))/12;
        %mean(Rx4Tx4Osample)
        %mean(Rx2Tx3Osample)
        %disp(b_average_R);
        %  mean(Rx2Tx4Osample)
        %mean(Rx3Tx3Osample)
        b_average_L = (mean(Rx5Tx7Osample) + mean(Rx5Tx6Osample) +  mean(Rx5Tx8Osample)+ mean(Rx7Tx7Osample)+ mean(Rx7Tx8Osample)+ mean(Rx7Tx10Osample)+ mean(Rx6Tx6Osample)+ mean(Rx6Tx8Osample)+ mean(Rx8Tx8Osample)+ mean(Rx8Tx10Osample) + mean(Rx6Tx9Osample) + mean(Rx8Tx9Osample))/12;
        %disp(b_average_L);
        sample = false;
        fclose(sampleFile);
        BCI = true; %start to BCI
    end
    if BCI && (p <= nsamples2)
        Rx1Tx1OBCI(p) = vec(1);
        %Rx1Tx1Hsample(n) = vec(2);
        Rx1Tx2OBCI(p) = vec(3);
        %Rx1Tx2Hsample(p) = vec(4);
        Rx1Tx3OBCI(p) = vec(5);
        %Rx1Tx3HBCI(p) = vec(6);
        Rx2Tx1OBCI(p) = vec(7);
        %Rx2Tx1HBCI(p) = vec(8);
        Rx2Tx3OBCI(p) = vec(9);
        %Rx2Tx3HBCI(p) = vec(10);
        Rx2Tx4OBCI(p) = vec(11);
        %Rx2Tx4HBCI(p) = vec(12);
        Rx3Tx2OBCI(p) = vec(13);
        %Rx3Tx2HBCI(p) = vec(14);
        Rx3Tx3OBCI(p) = vec(15);
        %Rx3Tx3HBCI(p) = vec(16);
        Rx4Tx3OBCI(p) = vec(17);
        %Rx4Tx3HBCI(p) = vec(18);
        Rx4Tx4OBCI(p) = vec(19);
        %Rx4Tx4HBCI(p) = vec(20);
        Rx3Tx5OBCI(p) = vec(21);
        %Rx3Tx5HBCI(p) = vec(22);
        Rx4Tx5OBCI(p) = vec(23);
        %Rx4Tx5HBCI(p) = vec(24);
        Rx5Tx7OBCI(p) = vec(25);
        %Rx5Tx7HBCI(p) = vec(26);
        Rx5Tx6OBCI(p) = vec(27);
        %Rx5Tx6HBCI(p) = vec(28);
        Rx5Tx8OBCI(p) = vec(29);
        %Rx5Tx8HBCI(p) = vec(30);
        Rx7Tx7OBCI(p) = vec(31);
        %Rx7Tx7HBCI(p) = vec(32);
        Rx7Tx8OBCI(p) = vec(33);
        %Rx7Tx8HBCI(p) = vec(34);
        Rx7Tx10OBCI(p) = vec(35);
        %Rx7Tx10HBCI(p) = vec(36);
        Rx6Tx6OBCI(p) = vec(37);
        %Rx6Tx6HBCI(p) = vec(38);
        Rx6Tx8OBCI(p) = vec(39);
        %Rx6Tx8HBCI(p) = vec(40);
        Rx8Tx8OBCI(p) = vec(41);
        %Rx8Tx8HBCI(p) = vec(42);
        Rx8Tx10OBCI(p) = vec(43);
        %Rx8Tx10HBCI(p) = vec(44);
        Rx6Tx9OBCI(p) = vec(45);
        %Rx6Tx9HBCI(p) = vec(46);
        Rx8Tx9OBCI(p) = vec(47);
        %Rx8Tx9HBCI(p) = vec(48);
        bcitime(p) = time;
        %if p == 1
            %test3 = 0;
        %else
            %test3 = 1;
        %end
        
        %new_average_R = (mean(Rx1Tx1OBCI) + mean(Rx1Tx2OBCI) +  mean(Rx1Tx3OBCI) + mean(Rx2Tx1OBCI)  + mean(Rx3Tx2OBCI)+  mean(Rx4Tx3OBCI) + mean( Rx3Tx5OBCI) + mean( Rx4Tx5OBCI + mean( Rx2Tx4OBCI) + mean(Rx3Tx3OBCI) + mean( Rx4Tx4OBCI)+ mean( Rx2Tx3OBCI)))/12 ;
        if p>windowsize
            filteredRx6Tx6OBCI = filtfilt(d,Rx6Tx6OBCI(1:p));
            figure(2);
            plot(bcitime(1:p), filteredRx6Tx6OBCI(1:p),' r' ,  bcitime(1:p), Rx6Tx6OBCI(1:p),'b');
            drawnow 
            average_R = (mean(Rx1Tx1OBCI((p-windowsize):(p))) + mean(Rx1Tx2OBCI((p-windowsize):(p))) +  mean(Rx1Tx3OBCI((p-windowsize):(p))) + mean(Rx2Tx1OBCI((p-windowsize):(p)))  + mean(Rx3Tx2OBCI((p-windowsize):(p)))+  mean(Rx4Tx3OBCI((p-windowsize):(p))) + mean( Rx3Tx5OBCI((p-windowsize):(p))) + mean( Rx4Tx5OBCI((p-windowsize):(p))) + mean(Rx2Tx4OBCI((p-windowsize):(p))) + mean(Rx3Tx3OBCI((p-windowsize):(p))) + mean(Rx4Tx4OBCI((p-windowsize):(p)))+ mean(Rx2Tx3OBCI((p-windowsize):(p))))/12 ;
            average_R2 = average_R/windowsize;
            %average_L = (average_L*p + (mean(Rx5Tx7OBCI) + mean(Rx5Tx6OBCI) + mean(Rx5Tx8OBCI) + mean(Rx7Tx7OBCI)+ mean(Rx7Tx8OBCI) + mean(Rx7Tx10OBCI) + mean(Rx6Tx6OBCI) + mean(Rx6Tx8OBCI) + mean(Rx8Tx8OBCI) + mean(Rx8Tx10OBCI) + mean(Rx6Tx9OBCI) + mean(Rx8Tx9OBCI))/12)/(p +test3);
            %average_L = ((mean(Rx5Tx7OBCI(p):(windowsize+p)) + mean(Rx5Tx6OBCI(p):(windowsize+p)) + mean(Rx5Tx8OBCI(1+p):(windowsize+p)) + mean(Rx7Tx7OBCI(p):(windowsize+p))+ mean(Rx7Tx8OBCI(p):(windowsize+p)) + mean(Rx7Tx10OBCI(p):(windowsize+p)) + mean(Rx6Tx6OBCI(p):(windowsize+p)) + mean(Rx6Tx8OBCI(p):(windowsize+p)) + mean(Rx8Tx8OBCI(p):(windowsize+p)) + mean(Rx8Tx10OBCI(p):(windowsize+p)) + mean(Rx6Tx9OBCI(p):(windowsize+p)) + mean(Rx8Tx9OBCI(p):(windowsize+p)))/12);
            %average_L2 = average_L/windowsize;
            if nsamples2>p
            resultR = average_R2 - b_average_R;
            %resultL = average_L2 - b_average_L;
            disp("resultR");
            disp(resultR);
            %disp("resultL");
            %disp(resultL);
            %disp("newaverage");
            %disp(new_average_R);
            %disp ('AverageRbaseline');
            %disp(b_average_R);
            %disp('AverageR');
            %disp(average_R);
            if (resultR >2.0)
                disp("right activated");
                %output = 1;
                %outlet.push_sample(output);
            end
            %if (resultL >2.0)
                %disp("left activated");
                %output = 2;
                %outlet.push_sample(output);
            %end
            end
        end
        %average_R = (average_R*p + new_average_R) /(p + test3);
        %
        %disp("averageR");
        %disp(average_R);
        
        %disp("averageL");
        %disp(average_L);

        p = p+1;
    elseif BCI

        BCI = false;
        %setup = true;
    end
    
end


   