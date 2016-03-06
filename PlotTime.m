figure(1)
plot(linspace(-100,700,410),squeeze(mean(mean(time.s01.nof.d(:,[1 6],:),3),2)),'r')
hold on
plot(linspace(-100,700,410),squeeze(mean(mean(time.s01.nof.d(:,[2:5],:),3),2)),':.r')
hold on
plot(linspace(-100,700,410),squeeze(mean(mean(time.s03.nof.d(:,[1 6],:),3),2)),'m')
hold on
plot(linspace(-100,700,410),squeeze(mean(mean(time.s03.nof.d(:,[2:5],:),3),2)),':.m')
legend('01-within','01-between','03-within','03-between')
xlim([-100 800])
hold off
xlabel('Time in ms')
ylabel('D-prime')

% 
% figure(1)
% plot(linspace(-100,700,410),squeeze(mean(mean(time.s01.nof.d,3),2)),'r')
% hold on
% plot(linspace(-100,700,410),squeeze(mean(mean(time.s01.bdl.d,3),2)),':.r')
% hold on
% plot(linspace(-100,700,410),squeeze(mean(mean(time.s03.nof.d,3),2)),'g')
% hold on
% plot(linspace(-100,700,410),squeeze(mean(mean(time.s03.bdl.d,3),2)),':.g')
% legend('01-no filter','01 delta','03-no filter','03 delta')
% xlim([-100 800])
% hold off
% xlabel('Time in ms')
% ylabel('D-prime')

