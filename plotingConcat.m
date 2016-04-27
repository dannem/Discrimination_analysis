figure
plot(linspace(-100,900,512),disc_01_bins)
hold on
plot(linspace(-100,900,512),disc_05_bins)
hold on
plot(linspace(-100,900,512),disc_10_bins)
hold on
plot(linspace(-100,900,512),disc_20_bins)
axis([-80 880 0.48 0.54])
legend('1 bin','5 bis','10 bins','20 bins')