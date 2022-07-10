function out = runAllCases(app,wdir,dirdata,solvercall)

for k=1:length(dirdata)
    fname=dirdata(k).name;
    [~,fstr,~]=fileparts(fname);
    app.ProgrammessagesTextArea.Value{end+1} = [sprintf('Now processing file: %s...',fname)];

    cmd=['"' solvercall '" ' '"' fullfile(wdir,fname) '"'];
    if app.UseWineengineforLinuxusersCheckBox.Value ==1
        cmd = ['wine ' cmd];
    end
    drawnow;
    chdir(wdir);
    system(cmd);
    %clean the mess
    orig_state = warning;warning('off','all');
    if isfile(fullfile(wdir,'MODELS.1'))
        movefile(fullfile(wdir,'MODELS.1'),fullfile(wdir,[fstr '.1']))
    end

    if isfile(fullfile(wdir,'MODELS.2'))
        movefile(fullfile(wdir,'MODELS.2'),fullfile(wdir,[fstr '.2']))
    end

    if exist(fullfile(wdir,[fstr '.pch']),'file')==2 || exist(fullfile(wdir,[fstr '.pl4']),'file')==2
        %     delete(fullfile(wdir,'startup'));
        delete(fullfile(wdir,'*.bin'));
        delete(fullfile(wdir,[fstr '.dbg']));
        delete(fullfile(wdir,[fstr '.lis']));
        %     delete(fullfile(wdir,[fstr '.atp']));
        delete(fullfile(wdir,'*.tmp'));
        delete(fullfile(wdir,'*.000'));
        delete(fullfile(wdir,'*.gnu'));
    end
    warning(orig_state);
end

end