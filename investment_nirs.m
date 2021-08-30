function investment_nirs(Subject)

ppt_title='investment_nirs.ppt';

inv_name={'normalizedBinary'};
nirs_name={'normalizeddiff0periodbase'};
ch_name={'ch1','ch7','ch8'};
hz=50;

for ci=1:length(inv_name)
    for cn=1:length(nirs_name)
        for nirs_ch=1:3
            figure
            %title_discr=['Investment ',inv_name{ci},' Nirs ',nirs_name{cn}, ch_name{nirs_ch}];
            title_discr=['Investment and Nirs ', ch_name{nirs_ch}];
            for cs=1:length(Subject)
                if(~isempty(Subject(cs).flt(ci).investment))&&(~isempty(Subject(cs).flt(cn).nirs(nirs_ch).thb))
                    nirs_length=min(length(Subject(cs).flt(cn).nirs(nirs_ch).thb),hz*length(Subject(cs).flt(ci).investment));
                    x=nanstd(Subject(cs).flt(ci).investment);
                    y=nanmean(Subject(cs).flt(cn).nirs(nirs_ch).thb(nirs_length,1));
                    plot(x,y,'o')
                    xlabel('Variance of Investment')
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
end
    
end

            