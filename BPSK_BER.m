clc;clear all;close all;
n_bits = 1000000;%no of bits
signal = randsrc(1, n_bits);%original signal
Eb = 1;%energy per bit
SNR_db = 0:0.5:12;%different SNR values in db
for i = 1:1:length(SNR_db)%going through each SNR value
    SNR = 10^(SNR_db(i)/10);%calculating SNR
    no = Eb/SNR;% No is the Noise Spectral Density
    n = sqrt(no/2)*randn(1, n_bits);%generating noise
    r_signal = Eb*signal + n;%noise added signal(received signal)
    for j = 1:1:n_bits %iterating through each bit
        x(j) = 0;%initializing the detection part
        if (r_signal(j) >= 0)%if signal value is more than 0 then we consider the bit is 1
            x(j) = 1;
        else %if signal value is less than 0 then we consider the bit is 0
            x(j) = -1;
        end
    end
    error(i) = 0;%initializing the error calculation part
     for j = 1:1:n_bits   
       if (x(j) ~= signal(j))%if detected signal is not equal to the original signal then increment error counter
           error(i)= error(i) + 1;
      end
     end
   BER(i) = error(i)/n_bits; %calculating BER
   theoratical_BER(i) = (0.5)*erfc(sqrt(SNR));
end
BER
theoratical_BER
semilogy(SNR_db,BER,"o")
hold on
semilogy(SNR_db,theoratical_BER);title("SNR vs BER curve");xlabel("SNR");
ylabel("BER");legend({'BER','Theoretical BER'})






