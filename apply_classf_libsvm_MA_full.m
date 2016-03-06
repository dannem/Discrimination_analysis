
%%%simplified classf to speed things up unlike:
%%%[ap, dp, MI, c_mn, c_std]=apply_classf_libsvm_MA_full(V_sel,univar_cond, idpair)
%%%can run apply_classf_libsvm_onepair for each voxel-ROI later for better estimates
%%% 1-time points, 2-identities/expressions, 3-blocks
function [ap, d]=apply_classf_libsvm_MA_full(V_sel, idpair,emo) %dp

case_n=size(V_sel,3);

S=case_n; N=case_n;
pS1=S/(S+N);
pS0=N/(S+N);
case_n2=case_n*2;

    
categ_k=idpair(1, 1);
categ_k2=idpair(1, 2);
if emo==1 %training on neutral
    categ_k=categ_k*2-1; %preparing indices for two neutral idenities for training
    categ_k2=categ_k2*2-1; %preparing indices for two neutral idenities for training
    categ_l=idpair(1, 1)*2; %preparing indices for two happy idenities for test
    categ_l2=idpair(1, 2)*2; %preparing indices for two happy idenities for test
elseif emo==2 %training on happy
    categ_k=categ_k*2; %preparing indices for two happy idenities for training
    categ_k2=categ_k2*2; %preparing indices for two happy idenities for training
    categ_l=idpair(1, 1)-1; %preparing indices for two neutral idenities for test
    categ_l2=idpair(1, 2)-1; %preparing indices for two neutral idenities for test
else
    error('No emotion specified')
end

% preparing training matrix
V_sel_2s=V_sel(:, [categ_k categ_k2],:);
V_sel_2s=reshape(V_sel_2s, size(V_sel_2s, 1), size(V_sel_2s, 2)*size(V_sel_2s, 3));% concatenating identities two under one coming from different blocks.
V_sel_2s=V_sel_2s';
lbls=repmat([0; 1], [case_n 1]);

%preparing testing matrix
V_sel_2l=V_sel(:, [categ_l categ_l2],:);
V_sel_2l=reshape(V_sel_2l, size(V_sel_2l, 1), size(V_sel_2l, 2)*size(V_sel_2l, 3));% concatenating identities two under one coming from different blocks.
V_sel_2l=V_sel_2l';


H=0;FA=0;

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

    %%%set c=1 to speed things up
    c=1;


    optstr=['-s 0 -t 0 -c ', num2str(c), ' -q'];
    svmStruct = libsvm_svmtrain(train_lbl, train_V, optstr);
    [lbl_clsf, ~, ~] = libsvm_svmpredict(test_lbl, test_V, svmStruct);

    acc(1, case_k)=mean(single(lbl_clsf==test_lbl));

    H=H+sum(double((lbl_clsf==1) & (test_lbl==1)));
    FA=FA+sum(double((lbl_clsf==1) & (test_lbl==0)));

end


[H, FA, d]=dprime(H,S,FA,N, 'yesno');


ap=mean(acc(1, :), 2);
%dp=d;

    
