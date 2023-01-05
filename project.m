%% Read Voice 
[signal_1, frequency_sampling1] = audioread('siganls/audio1.wav');
[signal_2, frequency_sampling2] = audioread('siganls/audio2.wav');
[signal_3, frequency_sampling3] = audioread('siganls/audio3.wav');

%% Sum first and second channel
signal_1 = signal_1(:, 1)+signal_1(:, 2);
signal_2 = signal_2(:, 1)+ signal_2(:, 2);
signal_3 = signal_3(:, 1)+signal_3(:, 2);

%% frequency Sampling 
frequency_sampling = frequency_sampling1;

%% set maxuim length between 3 signals
length_1 = length(signal_1);
length_2 = length(signal_2);
length_3 = length(signal_3);

N = max([length_1, length_2, length_3]);

%% make 3 signals be same
signal_1 = [signal_1;zeros(N-length_1, 1)];
signal_2 = [signal_2;zeros(N-length_2, 1)];
signal_3 = [signal_3;zeros(N-length_3, 1)];

%% get time and frequencyuency interval
t = linspace(0, N/frequency_sampling, N);
frequency_d = frequency_sampling/2;
frequency = -frequency_d : frequency_sampling/N: frequency_d - frequency_sampling/N;

%% frequencyuency Domin
signal_1_fft = fftshift(fft(signal_1));
signal_2_fft = fftshift(fft(signal_2));
signal_3_fft = fftshift(fft(signal_3));

phase_signal_1 = unwrap(angle(signal_1_fft));
phase_signal_2 = unwrap(angle(signal_2_fft));
phase_signal_3 = unwrap(angle(signal_3_fft));

%% Carrie in frequencyuency Domin
Carrier_frequencyuency_1 = 5000;
Carrier_frequencyuency_2 = 3 * 5000;

WC_1 = 2*pi * Carrier_frequencyuency_1;
WC_2 = 2*pi * Carrier_frequencyuency_2;

%% Carrier in time Domain
carrier_signal_1 = cos(WC_1 * t); 
carrier_signal_2 = cos(WC_2 * t);
carrier_signal_3 = sin(WC_2 * t); 

phase_carrier_signal_1 = unwrap(angle(fftshift(fft(carrier_signal_1))));
phase_carrier_signal_2 = unwrap(angle(fftshift(fft(carrier_signal_2))));
phase_carrier_signal_3 = unwrap(angle(fftshift(fft(carrier_signal_3))));

%% Modulation
modulatedSignal_t1 = signal_1' .* carrier_signal_1;
modulatedSignal_t2 = signal_2' .* carrier_signal_2;
modulatedSignal_t3 = signal_3' .* carrier_signal_3;

modulated_signal_f1 = fftshift(fft(modulatedSignal_t1));
modulated_signal_f2 = fftshift(fft(modulatedSignal_t2));
modulated_signal_f3 = fftshift(fft(modulatedSignal_t3));

phase_modulation_1 = unwrap(angle(modulated_signal_f1));
phase_modulation_2 = unwrap(angle(modulated_signal_f2));
phase_modulation_3 = unwrap(angle(modulated_signal_f3));

%% Add modulated signals
Modulated_Signal = modulatedSignal_t1 + modulatedSignal_t2 + modulatedSignal_t3;

Modulated_Signal_f = fftshift(fft(Modulated_Signal));
phase_mod = unwrap(angle(Modulated_Signal_f));

frequncy_BandPass = Carrier_frequencyuency_1;

%% Synchronous Modulation for 3 signals
FileNames=["Out_1" "Out_2" "Out_3"];
Carries=[carrier_signal_1 ;carrier_signal_2; carrier_signal_3];
disp(length(Carries))
for i = 1:3
    disp(i)
    demodulation(Modulated_Signal,frequncy_BandPass,FileNames(i), Carries(i,:,:), frequency_sampling);
end

%%
% Phase Shift: 10
Carries_phase_10 = CarriersPhase(Carrier_frequencyuency_1, Carrier_frequencyuency_2, 10,t);
FileNames_phases_10=["Out_1_phase_10" "Out_2_phase_10" "Out_3_phase_10"];
for i = 1:3
    demodulation(Modulated_Signal,frequncy_BandPass,FileNames_phases_10(i), Carries_phase_10(i,:,:), frequency_sampling);
end

% Phase Shift: 30
Carries_phase_30 = CarriersPhase(Carrier_frequencyuency_1, Carrier_frequencyuency_2, 30,t);
FileNames_phases_30=["Out_1_phase_30" "Out_2_phase_30" "Out_3_phase_30"];
for i = 1:3
    demodulation(Modulated_Signal,frequncy_BandPass,FileNames_phases_30(i), Carries_phase_30(i,:,:), frequency_sampling);
end

% Phase Shift: 90
Carries_phase_90 = CarriersPhase(Carrier_frequencyuency_1, Carrier_frequencyuency_2, 90,t);
FileNames_phases_90=["Out_1_phase_90" "Out_2_phase_90" "Out_3_phase_90"];
for i = 1:3
    demodulation(Modulated_Signal,frequncy_BandPass,FileNames_phases_90(i), Carries_phase_90(i,:,:), frequency_sampling);
end

%%
% local carrier frequencyuency different than Fc by 2 Hz in Demodulation
Carries_shift_2 = CarriersDifferentFc(Carrier_frequencyuency_1, Carrier_frequencyuency_2, 2,t);
FileNames_shift_2=["Out_1_shift_2" "Out_2_shift_2" "Out_3_shift_2"];
for i = 1:3
    demodulation(Modulated_Signal,frequncy_BandPass,FileNames_shift_2(i), Carries_shift_2(i,:,:), frequency_sampling);
end

%  local carrier frequencyuency different than Fc by 10 Hz in Demodulation

Carries_shift_10 = CarriersDifferentFc(Carrier_frequencyuency_1, Carrier_frequencyuency_2, 10,t);
FileNames_shift_10=["Out_2_shift_10" "Out_2_shift_10" "Out_3_shift_10"];
for i = 1:3
    demodulation(Modulated_Signal,frequncy_BandPass,FileNames_shift_10(i), Carries_shift_10(i,:,:), frequency_sampling);
end

% Ploting  Signals
plot_signal(t, frequency.', phase_signal_1,signal_1, abs(signal_1_fft),1, 'Signal 1');
plot_signal(t, frequency.', phase_signal_2,signal_2, abs(signal_2_fft),2, 'Signal 2');
plot_signal(t, frequency.', phase_signal_3,signal_3, abs(signal_3_fft),3, 'Signal 3');

% Ploting Modulated Signals
plot_signal(t, frequency.',phase_modulation_1,modulatedSignal_t1, abs(modulated_signal_f1),4, 'Modulated Signal 1');
plot_signal(t, frequency.', phase_modulation_2,modulatedSignal_t2, abs(modulated_signal_f2),5, 'Modulated Signal 2');
plot_signal(t, frequency.', phase_modulation_3,modulatedSignal_t3, abs(modulated_signal_f3),6, 'Modulated Signal 3');

function plot_signal(length_t, f,angle, time, freq,counter, Time)
    figure(counter)
    subplot(3, 1, 1)
    plot(length_t, time)
    xlabel('time')
    %title of time Domain
    title(strcat(Time, ' signal in time Domin'))
    subplot(3, 1, 2)
    plot(f, freq)
    xlabel('f')
    %title of frequency Domain
    title(strcat(Time, ' Signal in frequency Domain'))
    subplot(3, 1, 3)
    plot(f, angle)
    ylabel('phase')
    xlabel('f')
    %title of phase
    title(strcat(Time, ' Phase'))
end

function demodulation(signal_modulation, frequncy_BandPass, out_name, carrier_signal, frequency_signal_sampling)
    demodulationdSignal = 2 * (signal_modulation .* carrier_signal);
    lpf = lowpass(demodulationdSignal, frequncy_BandPass, frequency_signal_sampling);
    audiowrite(strcat("Output_signals/", out_name, '.wav'), lpf, frequency_signal_sampling);
end

function Array_of_carries = CarriersPhase(Carrier_frequencyuency_1, Carrier_frequencyuency_2, deg,time)

     carry_1 = cos((2*pi * Carrier_frequencyuency_1 * time) + ((deg * pi) / 180));
     carry_2 = cos((2*pi * Carrier_frequencyuency_2 * time) + ((deg * pi) / 180));
     carry_3 = sin((2*pi * Carrier_frequencyuency_2 * time) + ((deg * pi) / 180));
     Array_of_carries=[carry_1; carry_2; carry_3];
end

function Array_of_carries  = CarriersDifferentFc(Carrier_frequencyuency_1, Carrier_frequencyuency_2, frequency_dc,t)

     carry_1 = cos(2*pi * (Carrier_frequencyuency_1 + frequency_dc) * t);
     carry_2 = cos(2*pi * (Carrier_frequencyuency_2 + frequency_dc) * t);
     carry_3 = sin(2*pi * (Carrier_frequencyuency_2 + frequency_dc) * t);
     Array_of_carries=[carry_1; carry_2; carry_3];
end