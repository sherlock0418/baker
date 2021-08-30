function ramda_nirs_quantile_analysis(Subject)
% You need to run
% Subject = fitting_MM2015(Subject)
% in advance.

ppt_title='ramda_nirs_quantile_analysis.ppt';

R=[];NIRS=[];
LLH_MM=[];LLH_S=[];
ch_name={'ch3','ch7','ch8'};
counter=0;
for cs=1:length(Subject)
    if(~isempty(Subject(cs).flt(1).investment))&&(~isempty(Subject(cs).flt(1).nirs(1).thb))
        counter=counter+1;
        R(1,counter)=Subject(cs).ramda;
        for cch=1:3
            NIRS(cch,counter)=Subject(cs).ave_nirs(cch);
        end
    end
end

% ramda sort quantile
[pv_sorted]=sort(R,'ascend');
for numb_div=2:3
    div_span=length(R)/numb_div;
    
    for cthv=1:numb_div
        if(cthv==1)
            thv(cthv)=pv_sorted(1);
        else
            thv(cthv)=pv_sorted(ceil(div_span*(cthv-1)));
        end
        G(cthv).R=[];
        G(cthv).NIRS1=[];G(cthv).NIRS2=[];G(cthv).NIRS3=[];
    end

    clear g_label
    for cc=1:length(R)
        if(thv(numb_div)<=R(1,cc))
            g_label(1,cc)=numb_div;
        end
        for cdi=1:numb_div-1
            if(thv(cdi)<=R(1,cc))&&(thv(cdi+1)>R(1,cc))
                g_label(1,cc)=cdi;
            end
        end
    end

    for cc=1:length(R(1,:))
        G(g_label(1,cc)).R=[G(g_label(1,cc)).R,R(1,cc)];
        G(g_label(1,cc)).NIRS1=[G(g_label(1,cc)).NIRS1 NIRS(1,cc)];
        G(g_label(1,cc)).NIRS2=[G(g_label(1,cc)).NIRS2 NIRS(2,cc)];
        G(g_label(1,cc)).NIRS3=[G(g_label(1,cc)).NIRS3 NIRS(3,cc)];
    end

     for cdi=1:numb_div
        ave_vec(1,cdi)=nanmean(G(cdi).NIRS1);
        ave_vec(2,cdi)=nanmean(G(cdi).NIRS2);
        ave_vec(3,cdi)=nanmean(G(cdi).NIRS3);
     end

     figure
     for cch=1:3        
        subplot(1,3,cch)
        bar(ave_vec(cch,:))
        xlabel('Ramda')
        ylabel(['OxyHb Nirs ',ch_name{cch}])
     end
     title_discr=['Div',num2str(numb_div),'- Nirs vs Ramda'];
     saveppt(ppt_title, title_discr)
     cd ./figs
     savefig(title_discr)
     cd ../
     close all
     
     %%% Anova analysis
     
     clear AnovaY
     for cdiv=1:numb_div
         lv(cdiv)=length(G(cdiv).NIRS1);
     end
     
     numb_gs=min(lv);
     for cdiv=1:numb_div
         if(cdiv==numb_div)
             AnovaY(:,cdiv)=G(cdiv).NIRS1(1,end-numb_gs+1:end)';
         else
            AnovaY(:,cdiv)=G(cdiv).NIRS1(1,1:numb_gs)';
         end
     end
     [p_NIRS1,t,stats] = anova1(AnovaY);
     title_discr=['Div',num2str(numb_div),'- Nirs ch3 vs Ramda -Anova'];
     cd ./figs
         writecell(t,'anova.xlsx','Sheet',title_discr)
     cd ../

%      %c = multcompare(stats)
%      title_discr=['Div',num2str(numb_div),'- NirsCH 3 vs Ramda'];
%      boxplot(AnovaY)
%      xlabel('Ramda')
%      ylabel('OxyHb')
%      saveppt(ppt_title, title_discr)
%      cd ./figs
%      savefig(title_discr)
%      cd ../
%      close all
     
     clear AnovaY
     for cdiv=1:numb_div
         lv(cdiv)=length(G(cdiv).NIRS2);
     end
     numb_gs=min(lv);
     for cdiv=1:numb_div
         if(cdiv==numb_div)
             AnovaY(:,cdiv)=G(cdiv).NIRS2(1,end-numb_gs+1:end)';
         else
            AnovaY(:,cdiv)=G(cdiv).NIRS2(1,1:numb_gs)';
         end
     end
      [p_NIRS1,t,stats] = anova1(AnovaY);
     title_discr=['Div',num2str(numb_div),'- Nirs ch7 vs Ramda -Anova'];
     cd ./figs
         writecell(t,'anova.xlsx','Sheet',title_discr)
     cd ../
     
%      %c = multcompare(stats)
%      title_discr=['Div',num2str(numb_div),'- NirsCH 7 vs Ramda'];
%      boxplot(AnovaY)
%      xlabel('Ramda')
%      ylabel('OxyHb')
%      saveppt(ppt_title, title_discr)
%      cd ./figs
%      savefig(title_discr)
%      cd ../
%      close all
     
     clear AnovaY
     for cdiv=1:numb_div
         lv(cdiv)=length(G(cdiv).NIRS3);
     end
     numb_gs=min(lv);
     for cdiv=1:numb_div
         if(cdiv==numb_div)
             AnovaY(:,cdiv)=G(cdiv).NIRS3(1,end-numb_gs+1:end)';
         else
            AnovaY(:,cdiv)=G(cdiv).NIRS3(1,1:numb_gs)';
         end
     end
      [p_NIRS1,t,stats] = anova1(AnovaY);
     title_discr=['Div',num2str(numb_div),'- Nirs ch8 vs Ramda -Anova'];
     cd ./figs
         writecell(t,'anova.xlsx','Sheet',title_discr)
     cd ../
     
%      %c = multcompare(stats)
%      title_discr=['Div',num2str(numb_div),'- NirsCH 8 vs Ramda'];
%      boxplot(AnovaY)
%      xlabel('Ramda')
%      ylabel('OxyHb')
%      saveppt(ppt_title, title_discr)
%      cd ./figs
%      savefig(title_discr)
%      cd ../
%      close all
end
