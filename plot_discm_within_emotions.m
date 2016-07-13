a7=output_disc_07_within.ap;
a7=squeeze(mean(a7,3));
b7=output_disc_07_across.ap;
b7=squeeze(mean(mean(b7,2),3));
c7=[a7 b7];

a5=output_disc_05_within.ap;
a5=squeeze(mean(a5,3));
b5=output_disc_05_across.ap;
b5=squeeze(mean(mean(b5,2),3));
c5=[a5 b5];

a3=output_disc_03_within.ap;
a3=squeeze(mean(a3,3));
b3=output_disc_03_across.ap;
b3=squeeze(mean(mean(b3,2),3));
c3=[a3 b3];

figure
plot(linspace(-100,900,512),k,'DisplayName','c'); legend('happy','neutral','all')


%% separately for familiarity
% out=perm_separation(60,54);

% a5=output_disc_05_within.ap;
b5=output_disc_05.ap;

% a5fl=a5(:,:,out.indOne);
% a5fl=squeeze(mean(a5fl,3));
% a5fl=squeeze(mean(a5fl,2));
b5fl=b5(:,:,out.indOne);
b5fl=squeeze(mean(mean(b5fl,3),2));

% a5fm=a5(:,:,out.indTwo);
% a5fm=squeeze(mean(a5fm,3));
% a5fm=squeeze(mean(a5fm,2));
% b5fm=b5(:,:,out.indTwo);
% b5fm=squeeze(mean(mean(b5fm,3),2));

% a5ac=a5(:,:,out.indAcross);
% a5ac=squeeze(mean(a5ac,3));
% a5ac=squeeze(mean(a5ac,2));
b5ac=b5(:,:,out.indAcross);
b5ac=squeeze(mean(mean(b5ac,3),2));
out5=[a5fl b5fl];

figure
% plot(linspace(-100,900,512),out7,'DisplayName','c'); legend('within unfamiliar',...
%     'across unfamiliar','within famous','across famous','within all','across all');

plot(linspace(-100,900,512),out5,'DisplayName','c'); legend('across unfamiliar','across all');
%%
a5=output_disc_05_within.ap;
a5=squeeze(mean(a5,3));
b5=output_disc_05_across.ap;
b5=squeeze(mean(mean(b5,2),3));
c5=[a5 b5];

a3=output_disc_03_within.ap;
a3=squeeze(mean(a3,3));
b3=output_disc_03_across.ap;
b3=squeeze(mean(mean(b3,2),3));
c3=[a3 b3];

figure
plot(linspace(-100,900,512),k,'DisplayName','c'); legend('happy','neutral','all')

