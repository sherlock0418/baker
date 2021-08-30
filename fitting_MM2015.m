function Subject = fitting_MM2015(Subject)

inv_name={'normalizedBinary'};
nirs_name={'normalizeddiff0periodbase'};
ch_name={'ch3','ch7','ch8'};
ppt_title='ramda_nirs_result.ppt';


    for cch=1:3
        for cs=1:length(Subject)
            if(~isempty(Subject(cs).flt(1).investment))&&(~isempty(Subject(cs).flt(1).nirs(cch).thb))
                f_rtn=Subject(cs).fundamental_rtn;
                inv=Subject(cs).flt(1).investment;
                ave_nirs=nanmean(Subject(cs).flt(1).nirs(cch).thb);

                optnew = optimset('Display','notify','MaxFunEvals',2000,'TolFun',1e-6);
                params0=0;
                func=@(params)minus_log_likelyhood(f_rtn,inv,params);
                [params_ml, min_mllh, exitsig] = fminunc(func,params0,optnew);
                Subject(cs).ramda=params_ml;%this shows log(ramda)
                Subject(cs).llh_MM=-min_mllh;
                Subject(cs).ave_nirs(cch)=ave_nirs;
                numb_param=length(params_ml);
                numb_d=length(inv);
                Subject(cs).aic_MM=-2*(-min_mllh)+2*numb_param;
                Subject(cs).R2_MM=-((-min_mllh)-(numb_d*log(1/2)))/(numb_d*log(1/2));
            else
                Subject(cs).ramda=[];
                Subject(cs).llh_MM=[];
                Subject(cs).ave_nirs=[];
                Subject(cs).aic_MM=[];
                Subject(cs).R2_MM=[];
            end
        end

    end

end


function [mllh]=minus_log_likelyhood(f_rtn,inv,params)
ramda=params(1);

t=[inv,1-inv];
[A]=repmat([f_rtn/exp(ramda) 0],length(inv(:,1)),1);
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
        