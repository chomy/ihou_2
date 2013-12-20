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

N <- 10000
t <- 1:N/N
C = 1
A = 0.7
sig <- (A*sin(2*pi*3*t) + C) * sin(2*pi*30*t)

Q = sig * cos(2*pi*32*t)
I = sig * sin(2*pi*32*t)

cutoff = 980 
Q2 <- lpf(Q, t, cutoff, N)
I2 <- lpf(I, t, cutoff, N)
result = sqrt(Q2*Q2 + I2*I2)
plot(t,result, type='l')
