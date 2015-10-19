sr      = 44100;
st1     = 0;
et1     = 1;
f1      = 441;
amp1    = 0.5;

st2     = 1;
et2     = 2;
f2      = 882;
amp2    = 0.5;


testSig1 = [ signalGenerator(sr,st1,et1,f1,amp),signalGenerator(sr,st2,et2,f2,amp2)];
testSig2 = [ signalGenerator(sr,st1,et1,f1,amp),signalGenerator(sr,st2,et2,f2,0.9)];

figure

subplot(2,1,1)
plot(testSig1)

subplot(2,1,2)
plot(testSig2)
