function model_comparison(Subject)
% You need to run
% Subject = fitting_MM2015(Subject)
% Subject = fitting_Sims2003(Subject)
% in advance.

K=[];R=[];NIRS=[];
LLH_MM=[];LLH_S=[];
counter=0;
for cs=1:length(Subject)
    if(~isempty(Subject(cs).flt(1).investment))&&(~isempty(Subject(cs).flt(1).nirs(1).thb))
        counter=counter+1;
        LLH_MM(1,counter)=Subject(cs).llh_MM;
        AIC_MM(1,counter)=Subject(cs).aic_MM;
        R2_MM(1,counter)=Subject(cs).R2_MM;
        for cm=1:6
            LLH_S(cm,counter)=Subject(cs).llh_Sims(cm);
            AIC_S(cm,counter)=Subject(cs).aic_Sims(cm);
            R2_S(cm,counter)=Subject(cs).R2_Sims(cm);
        end
    end
end

MCmat(1,:)=[nanmean(LLH_MM),nanmean(LLH_S')];
MCmat(2,:)=[nanstd(LLH_MM),nanstd(LLH_S')];
MCmat(3,:)=[nanmean(AIC_MM),nanmean(AIC_S')];
MCmat(4,:)=[nanmean(R2_MM),nanmean(R2_S')];
cd ./figs
writematrix(MCmat,'model_comparison.xlsx')
cd ../