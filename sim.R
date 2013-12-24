# Low Pass Filter (LPF)
lpf <- function(signal, time, cutoff, smplfreq){
	offset <- min(signal)
	if(offset>0){
		offset = 0
	}
	spec <- fft(signal + abs(offset))
	idx = cutoff/(smplfreq/length(signal))
	spec[idx:length(spec)] = 0
	abs(fft(spec, inverse=TRUE))/length(spec)+offset 
}

N <- 10000 # Sampling Frequency
t <- 1:N/N # Time
C = 1	 # Carrier Amplitude
fc= 30     # Carrier Frequency
A = 0.7    # Signal Amplitude
fs= 3	 # Signal Frequency
fl= 20     # Local Osc Freq

# AM Modulation
Vam <- (A*sin(2*pi*fs*t) + C) * sin(2*pi*fc*t)

Q = Vam * cos(2*pi*fl*t)
I = Vam * sin(2*pi*fl*t)

cutoff = 15 # Cutoff Frequency of LPF
Q2 <- lpf(Q, t, cutoff, N)
I2 <- lpf(I, t, cutoff, N)

# Demodulated Signal
Vdm = sqrt(Q2*Q2 + I2*I2)

# Outout Signal
Vout = lpf(Vdm, t, 10, N)
