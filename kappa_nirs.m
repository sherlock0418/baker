function kappa_nirs(Subject)
% You need to run
% Subject = fitting_Sims2003(Subject)
% in advance.

ppt_title='kappa_nirs.ppt';

inv_name={'normalizedBinary'};
nirs_name={'normalizeddiff0periodbase'};
ch_name={'ch3','ch7','ch8'};

% model_id=1; exp(myu)
% model_id=2; exp(myu/sig)
% model_id=3; exp(myu/exp(gamma))
% model_id=4; exp(myu/sig*exp(gamma))
% model_id=5; exp(myu)　with the loss aversion exp(delta)
% model_id=6; exp(myu/sig) with the loss aversion exp(delta)

for model_id=6:6   %use the best fit model
    for cch=1:3  
        figure
        %title_discr=['Model',num2str(model_id),' Kappa and Nirs- Investment ',inv_name{1},' NirsCH ',ch_name{cch},' Nirs ',nirs_name{1}];
        title_discr=['Kappa and Nirs ', nirs_name{1}];
        for cs=1:length(Subject)
            if(~isempty(Subject(cs).flt(1).investment))&&(~isempty(Subject(cs).flt(1).nirs(cch).thb))
                x=Subject(cs).kappa(model_id);
                y=Subject(cs).ave_nirs(cch);
                plot(x,y,'o')
                %title(title_discr)
                xlabel('Kappa')
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
end