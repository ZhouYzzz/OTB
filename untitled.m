seqs = configSeqsOTB100_slash;

inds = 1:4;

fid = fopen('/home/zhouyz/Documents/cvpr2018/imgs_SOTA/figures.tex','w');

    fprintf(fid,'\n\\begin{figure}[H]\n\\setlength{\\tabcolsep}{6pt}\n\\renewcommand{\\arraystretch}{0}\n\\caption{Qualitative evaluation on the OTB-2015 dataset. Bounding boxes of the five selected trackers are shown in different colors. The name of each sequence lies at the end of each page.}\n\\begin{tabular}{@{}c@{}c@{}c@{}c@{}c@{}c@{}}');
    for i = inds
        sn = seqs{i}.name;
        fprintf(fid,['\\includegraphics[width=0.2\\linewidth]{imgs_SOTA/' sn '_1/1.png}&\n']);
        fprintf(fid,['\\includegraphics[width=0.2\\linewidth]{imgs_SOTA/' sn '_1/2.png}&\n']);
        fprintf(fid,['\\includegraphics[width=0.2\\linewidth]{imgs_SOTA/' sn '_1/3.png}&\n']);
        fprintf(fid,['\\includegraphics[width=0.2\\linewidth]{imgs_SOTA/' sn '_1/4.png}&\n']);
        fprintf(fid,['\\includegraphics[width=0.2\\linewidth]{imgs_SOTA/' sn '_1/5.png}&\n']);
        fprintf(fid,'\\\\\n');
    end
    fprintf(fid, '\\multicolumn{6}{c}{\\includegraphics[width=0.7\\linewidth]{imgs_SOTA/legend.pdf}}');
    fprintf(fid,'\\end{tabular}\n\\end{figure}\n');
    
        for i = inds(1:end-1)
        sn = seqs{i}.name;
        fprintf(fid,'{%s}, ', sn);
    end
    i = inds(end);
    sn = seqs{i}.name;
    fprintf(fid,'and {%s}.\n', sn);

inds = 5:12;



for ii = 1:12 % pages
    
    fprintf(fid,'\\newpage\n\\begin{figure}[H]\n\\setlength{\\tabcolsep}{6pt}\n\\renewcommand{\\arraystretch}{0}\n\\begin{tabular}{@{}c@{}c@{}c@{}c@{}c@{}c@{}}');
    for i = inds
        sn = seqs{i}.name;
        fprintf(fid,['\\includegraphics[width=0.2\\linewidth]{imgs_SOTA/' sn '_1/1.png}&\n']);
        fprintf(fid,['\\includegraphics[width=0.2\\linewidth]{imgs_SOTA/' sn '_1/2.png}&\n']);
        fprintf(fid,['\\includegraphics[width=0.2\\linewidth]{imgs_SOTA/' sn '_1/3.png}&\n']);
        fprintf(fid,['\\includegraphics[width=0.2\\linewidth]{imgs_SOTA/' sn '_1/4.png}&\n']);
        fprintf(fid,['\\includegraphics[width=0.2\\linewidth]{imgs_SOTA/' sn '_1/5.png}&\n']);
        fprintf(fid,'\\\\\n');
    end
        fprintf(fid, '\\multicolumn{6}{c}{\\includegraphics[width=0.7\\linewidth]{imgs_SOTA/legend.pdf}}');
    fprintf(fid,'\\end{tabular}\n\\end{figure}\n');
    
    for i = inds(1:end-1)
        sn = seqs{i}.name;
        fprintf(fid,'{%s}, ', sn);
    end
    i = inds(end);
    sn = seqs{i}.name;
    fprintf(fid,'and {%s}.\n', sn);
    
    inds = inds + 8; % next group
end

fclose(fid);