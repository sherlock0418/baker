function time_series(Subject)

ppt_title='time_series.ppt';

scount=0;
for cs=1:length(Subject)
    if(~isempty(Subject(cs).nirs(1).thb))
        scount=scount+1;
        title_discr=['Time series -Sample', num2str(scount)];

        price=Subject(cs).price;
        rtn=Subject(cs).rtn;
        inv=Subject(cs).investment;
        nirs_x3=Subject(cs).nirs(1).thb;
        nirs_x7=Subject(cs).nirs(2).thb;
        nirs_x8=Subject(cs).nirs(3).thb;

        figure
        subplot(3,2,1);plot(price);ylabel('Price')
        subplot(3,2,2);plot(inv);ylabel('Investment')
        subplot(3,2,3);plot(nirs_x3);ylabel('NIRS CH3')
        subplot(3,2,4);plot(nirs_x7);ylabel('NIRS CH7')
        subplot(3,2,5);plot(nirs_x8);ylabel('NIRS CH8')

        saveppt(ppt_title, title_discr)
        cd ./figs
        savefig(title_discr)
        cd ../
        close all
    end
end
        