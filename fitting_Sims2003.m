function Subject = fitting_Sims2003(Subject)

inv_name={'normalizedBinary'};
nirs_name={'normalizeddiff0periodbase'};
ch_name={'ch3','ch7','ch8'};
ppt_title='kappa_nirs_result.ppt';

% model_id=1; exp(myu)
% model_id=2; exp(myu/sig)
% model_id=3; exp(myu/exp(gamma))
% model_id=4; exp(myu/sig*exp(gamma))
% model_id=5; exp(myu)　with the loss aversion exp(delta)
% model_id=6; exp(myu/sig) with the loss aversion exp(delta)

    for model_id=1:6  
        for cch=1:3            

            for cs=1:length(Subject)
                if(~isempty(Subject(cs).flt(1).investment))
                    rtn=Subject(cs).rtn;
                    myu0=0;
                    sig0=Subject(cs).noise_scale;
                    inv=Subject(cs).flt(1).investment;
                    ave_nirs=nanmean(Subject(cs).flt(1).nirs(cch).thb);

                    optnew = optimset('Display','notify','MaxFunEvals',2000,'TolFun',1e-6);
                    if(model_id<=2)
                        params0=zeros(1,1);
                        func=@(params)minus_log_likelyhood_sims(model_id,rtn,inv,params,myu0,sig0);
                        [params_ml, min_mllh, exitsig] = fminunc(func,params0,optnew);
                        Subject(cs).kappa(model_id)=params_ml(1);
                        Subject(cs).llh_Sims(model_id)=-min_mllh;
                        Subject(cs).ave_nirs(cch)=ave_nirs;
                    elseif(model_id>2)&&(model_id<=4)
                        params0=zeros(2,1);
                        func=@(params)minus_log_likelyhood_sims(model_id,rtn,inv,params,myu0,sig0);
                        [params_ml, min_mllh, exitsig] = fminunc(func,params0,optnew);
                        Subject(cs).kappa(model_id)=params_ml(1);
                        Subject(cs).gamma=params_ml(2);
                        Subject(cs).llh_Sims(model_id)=-min_mllh;
                        Subject(cs).ave_nirs(cch)=ave_nirs;
                    elseif(model_id>4)&&(model_id<=6)
                        params0=zeros(2,1);
                        func=@(params)minus_log_likelyhood_sims(model_id,rtn,inv,params,myu0,sig0);
                        [params_ml, min_mllh, exitsig] = fminunc(func,params0,optnew);
                        Subject(cs).kappa(model_id)=params_ml(1);
                        Subject(cs).delta=params_ml(2);
                        Subject(cs).llh_Sims(model_id)=-min_mllh;
                        Subject(cs).ave_nirs(cch)=ave_nirs;                            
                    end
                    numb_param=length(params_ml);
                    numb_d=length(inv);
                    Subject(cs).aic_Sims(model_id)=-2*(-min_mllh)+2*numb_param;
                    Subject(cs).R2_Sims(model_id)=-((-min_mllh)-(numb_d*log(1/2)))/(numb_d*log(1/2));
                else
                    Subject(cs).kappa(model_id)=[];
                    Subject(cs).gamma=[];
                    Subject(cs).delta=[];
                    Subject(cs).llh_Sims(model_id)=[];
                    Subject(cs).ave_nirs=[];
                    Subject(cs).aic_MM=[];
                    Subject(cs).R2_MM=[];
                end
            end

        end
    end
end


function [mllh]=minus_log_likelyhood_sims(model_id,rtn,inv,params,myu0,sig0)
if(model_id<=2)
    kappa=params(1);
    [myu,sig]=KF(rtn,kappa,myu0,sig0);
    t=[inv,1-inv];
    if(model_id==1)
        for cp=1:length(myu(:,1))
            if(cp==1)
                A(cp,:)=[myu0,0];
            else
                A(cp,:)=[myu(cp-1,1),0];
            end
        end
    elseif(model_id==2)
        for cp=1:length(myu(:,1))
            if(cp==1)
                A(cp,:)=[myu0/((1+sig0)),0];
            else
                A(cp,:)=[myu(cp-1,1)/(sig(cp-1,1)+sig0),0];
            end
        end
    end
elseif(model_id>2)&&(model_id<=4)
    kappa=params(1);
    gamma=params(2);
    [myu,sig]=KF(rtn,kappa,myu0,sig0);
    t=[inv,1-inv];
    if(model_id==3)
        for cp=1:length(myu(:,1))
            if(cp==1)
                A(cp,:)=[myu0/exp(gamma),0];
            else
                A(cp,:)=[myu(cp-1,1)/exp(gamma),0];
            end
        end
    elseif(model_id==4)
        for cp=1:length(myu(:,1))
            if(cp==1)
                A(cp,:)=[myu0/((1+sig0)*exp(gamma)),0];
            else
                A(cp,:)=[myu(cp-1,1)/((sig(cp-1,1)+sig0)*exp(gamma)),0];
            end
        end
    end
elseif(model_id>4)&&(model_id<=6)
    kappa=params(1);
    delta=params(2);
    [myu,sig]=KF_lossaversion(rtn,kappa,delta,myu0,sig0);
    t=[inv,1-inv];
    if(model_id==5)
        for cp=1:length(myu(:,1))
            if(cp==1)
                A(cp,:)=[myu0,0];
            else
                A(cp,:)=[myu(cp-1,1),0];
            end
        end
    elseif(model_id==6)
        for cp=1:length(myu(:,1))
            if(cp==1)
                A(cp,:)=[myu0/((1+sig0)),0];
            else
                A(cp,:)=[myu(cp-1,1)/(sig(cp-1,1)+sig0),0];
            end
        end
    end
end


% [myu,sig]=KF(rtn,kappa,myu0,sig0);
% t=[inv,1-inv];
% 
% if(model_id==1)
%     for cp=1:length(myu(:,1))
%         if(cp==1)
%             A(cp,:)=[myu0/exp(gamma),0];
%         else
%             A(cp,:)=[myu(cp-1,1)/exp(gamma),0];
%         end
%     end
% elseif(model_id==2)
%     for cp=1:length(myu(:,1))
%         if(cp==1)
%             A(cp,:)=[myu0/((1+sig0)*exp(gamma)),0];
%         else
%             A(cp,:)=[myu(cp-1,1)/((sig(cp-1,1)+sig0)*exp(gamma)),0];
%             %sig0=Subject(cs).noise_scale;
%         end
%     end
% end

[sigma_mat]=calc_softmax_prob(A);

numb_O=length(t(1,:));
numb_N=length(t(:,1));
llh=0;
for cn=1:numb_N
    for co=1:numb_O
        llh=llh + t(cn,co)*log(sigma_mat(cn,co));
    end
end
mllh=-1*llh;

end

function [myu,sig]=KF(rtn,kappa,myu0,sig0)
ekappa=exp(kappa);
for cp=1:length(rtn(:,1))
    if(cp==1)
        myu(cp,1)=myu0;
        sig(cp,1)=sig0;
    else
        sig_n=sig(cp-1,1)/(exp(ekappa)-1);
        kg=1/(1+sig_n);
        ks=1/(1+(1/(exp(ekappa)-1)));
        myu(cp,1)=myu(cp-1,1) + kg*(rtn(cp-1,1)-myu(cp-1,1));
        sig(cp,1)=sig(cp-1,1) - ks*sig(cp-1,1);
    end
end
end

function [myu,sig]=KF_lossaversion(rtn,kappa,delta,myu0,sig0)
ekappa=exp(kappa);
for cp=1:length(rtn(:,1))
    if(cp==1)
        myu(cp,1)=myu0;
        sig(cp,1)=sig0;
    else
        sig_n=sig(cp-1,1)/(exp(ekappa)-1);
        kg=1/(1+sig_n);
        ks=1/(1+(1/(exp(ekappa)-1)));
        if(rtn(cp-1,1)<0)
            myu(cp,1)=myu(cp-1,1) + exp(delta)*kg*(rtn(cp-1,1)-myu(cp-1,1));
        else
            myu(cp,1)=myu(cp-1,1) + kg*(rtn(cp-1,1)-myu(cp-1,1));
        end
        sig(cp,1)=sig(cp-1,1) - ks*sig(cp-1,1);
    end
end
end

function [sigma_mat]=calc_softmax_prob(A)
numb_O=length(A(1,:));
numb_N=length(A(:,1));

for cn=1:numb_N
    sumsigma=0;
    for co=1:numb_O        
        sumsigma=sumsigma + exp(A(cn,co));        
    end
    sumA(cn)=sumsigma;
end

for cn=1:numb_N
    for co=1:numb_O        
        sigma_mat(cn,co)=exp(A(cn,co))/sumA(cn);       
    end
end
end
        