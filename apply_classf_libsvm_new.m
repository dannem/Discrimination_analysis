function [ap, d, c, acc]=apply_classf_libsvm_new(V_sel, idpair,emo,c) %dp
%% c recommended 1.
if nargin<4
    c=1;
end
case_n=size(V_sel,3);

S=case_n; N=case_n;
pS1=S/(S+N);
pS0=N/(S+N);
case_n2=case_n*2;

    

if emo==1 %training on neutral
    categ_k=idpair(1, 1)*2-1; %preparing indices for two neutral idenities for training
    categ_k2=idpair(1, 2)*2-1; %preparing indices for two neutral idenities for training
    categ_l=idpair(1, 1)*2; %preparing indices for two happy idenities for test
    categ_l2=idpair(1, 2)*2; %preparing indices for two happy idenities for test
elseif emo==2 %training on happy
    categ_k=idpair(1, 1)*2; %preparing indices for two happy idenities for training
    categ_k2=idpair(1, 2)*2; %preparing indices for two happy idenities for training
    categ_l=idpair(1, 1)*2-1; %preparing indices for two neutral idenities for test
    categ_l2=idpair(1, 2)*2-1; %preparing indices for two neutral idenities for test
else
    error('No emotion specified')
end

% preparing training matrix
V_sel_2s=V_sel(:, [categ_k categ_k2],:);
V_sel_2s=reshape(V_sel_2s, size(V_sel_2s, 1), size(V_sel_2s, 2)*size(V_sel_2s, 3));% concatenating identities two under one coming from different blocks.
V_sel_2s=V_sel_2s';
lbls=[0 1];
lbls=repmat(lbls,[1,case_n])';



%%
%preparing testing matrix
V_sel_2l=V_sel(:, [categ_l categ_l2],:);
V_sel_2l=reshape(V_sel_2l, size(V_sel_2l, 1), size(V_sel_2l, 2)*size(V_sel_2l, 3));% concatenating identities two under one coming from different blocks.
V_sel_2l=V_sel_2l';


H=0;FA=0;
tic
for case_k=1:case_n

    testind=[case_k*2-1 case_k*2];
    trainind=setdiff(1:case_n*2, testind);

    train_V=V_sel_2s(trainind, :); %taking only training cases
    test_V=V_sel_2l(testind, :); %taking only testing cases

    train_lbl=lbls(trainind, :);
    test_lbl=lbls(testind, :);

%     %scaling 0-1 if not already in main script across all obs, categs..
%     train_sz=size(train_V, 1);
%     test_sz=size(test_V, 1);
%     min_vals=min(train_V);
%     train_V=train_V-repmat(min_vals, [train_sz 1]);
%     max_vals=max(train_V);
%     train_V=train_V./repmat(max_vals, [train_sz 1]);
%     test_V=test_V-repmat(min_vals, [test_sz 1]);
%     test_V=test_V./repmat(max_vals, [test_sz 1]);

    optstr=['-s 0 -t 0 -c ', num2str(c), ' -q'];
    svmStruct = svmtrain(train_lbl, train_V, optstr);
    [lbl_clsf, ~, ~] = svmpredict(test_lbl, test_V, svmStruct,'-q');%optstr

    acc(1, case_k)=mean(single(lbl_clsf==test_lbl));

    H=H+sum(double((lbl_clsf==1) & (test_lbl==1)));
    FA=FA+sum(double((lbl_clsf==1) & (test_lbl==0)));
    
    
    

end

ap=mean(acc(1, :), 2);



H1 = H / S;
FA1 = FA/ N;
zH = icdf('Normal', H1,0,1);
zFA = icdf('Normal', FA1,0,1);
c = -(zH + zFA)/2;

% acc
% H=H
% FA=FA
[H, FA, d]=dprime(H,S,FA,N, 'yesno');


%dp=d;

    
