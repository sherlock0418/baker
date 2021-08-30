function ramda_nirs(Subject)
% You need to run
% Subject = fitting_MM2015(Subject)
% in advance.

ppt_title='ramda_nirs.ppt';

inv_name={'normalizedBinary'};
nirs_name={'normalizeddiff0periodbase'};
ch_name={'ch3','ch7','ch8'};

 for cch=1:3
    figure
    %title_discr=['Ramda and Nirs- Investment ',inv_name{1},' NirsCH ',ch_name{cch},' Nirs ',nirs_name{1}];
    title_discr=['Ramda and Nirs ', nirs_name{1}];
    for cs=1:length(Subject)
        if(~isempty(Subject(cs).flt(1).investment))&&(~isempty(Subject(cs).flt(1).nirs(cch).thb))
            x=Subject(cs).ramda;
            y=Subject(cs).ave_nirs(cch);
            plot(x,y,'o')
            xlabel('Ramda')
            ylabel('OxyHb')
            hold on
        end
    end
    hold off 
    saveppt(ppt_title, title_discr)
    cd ./figs
    savefig(title_discr)
    cd ../
    close all
 end

 
%%%Ramda and Fundamental return
figure
title_discr=['Ramda and fundamental return'];
ramda_loss=[];ramda_gain=[];
for cs=1:length(Subject)
    if(~isempty(Subject(cs).flt(1).investment))&&(~isempty(Subject(cs).flt(1).nirs(cch).thb))
        if(Subject(cs).fundamental_rtn<0)%loss case
            ramda_loss=[ramda_loss,Subject(cs).ramda];                        
        else
            ramda_gain=[ramda_gain,Subject(cs).ramda];
        end
    end
end
subplot(1,2,1)
boxplot(ramda_loss)
xlabel('Loss case')
ylabel('Ramda')
subplot(1,2,2)
boxplot(ramda_gain)
xlabel('Gain case')
ylabel('Ramda')
title(title_discr)
saveppt(ppt_title, title_discr)
cd ./figs
savefig(title_discr)
cd ../
close all



%%% Ramda and Noize
figure
title_discr=['Ramda and noize'];
ramda_small=[];ramda_large=[];
for cs=1:length(Subject)
    if(~isempty(Subject(cs).flt(1).investment))&&(~isempty(Subject(cs).flt(1).nirs(cch).thb))
        if(Subject(cs).noise_scale==0.001)%samll
            ramda_small=[ramda_small,Subject(cs).ramda];                        
        else
            ramda_large=[ramda_large,Subject(cs).ramda];
        end
    end
end
subplot(1,2,1)
boxplot(ramda_small)
xlabel('Small noize')
ylabel('Ramda')
subplot(1,2,2)
boxplot(ramda_large)
xlabel('Large noize')
ylabel('Ramda')
title(title_discr)
saveppt(ppt_title, title_discr)
cd ./figs
savefig(title_discr)
cd ../
close all

end
