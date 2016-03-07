function [installed] = checkPsychtoolbox
%CHECKPSYCHTOOLBOX Summary of this function goes here
%   Checks if psychtoolbox is installed by using a hack (By relying on a
%   exception to be generated when Psychtoolbox function
%   PsychtoolboxVersion is not availible;
%   TODO:
%           -Make sure the exception is what it should be
%           Made function, Done: -Probably create a cleaner version with psychtoolbox version
%            check.
%           -Create a seperate 'installer' file that will unzip
%           Psychtoolbox. This will cutdown on copy time and will
%           ultimately reduce time usage when moving the installation.
%           Though it will prolong the installation of Psychtoolbox, it
%           should only occour once.
%           Done :-It might be userfriendly to ask before installing xD
[doesExist, version] = psychtoolboxExists;
if doesExist
    disp('Psychtoolbox detected:');
    disp(version);
    installed = true;
else
    installed = false;
   disp('No Psychtoolbox detected');
   
       %Psychtoolbox does not Exist! 
    %This calls for: SetupPsychtoolbox!!
    if ~exist('Psychtoolbox\\SetupPsychtoolbox.m','file')
        %But it does not exist, not even the installer!
        errordlg('Psychtoolbox is not present! Unable to start a experiment!','CALL HELP, RUN! or redownload this...');
    else
        %The installer exists, luckely!
        if strcmp(questdlg('Do you want to install Psychtoolbox now? (you need it to run experiments!)','Psychtoolbox','Yes','No','Yes'),'Yes')
            msgbox('Now installing Psychtoolbox. Watch the console, you need to press a button.   Wait for:"Press RETURN or ENTER to confirm you read and understood the above message."  This can take a few minutes...','Warning, you need to do stuff');
            run('Psychtoolbox\\SetupPsychtoolbox.m');
            if psychtoolboxExists
                installed = true;
            end
        else
            waitfor(msgbox('Psychtoolbox not installed. You can still create or edit experiments but you cannot run them','Note'))
        end
    end
end

end

