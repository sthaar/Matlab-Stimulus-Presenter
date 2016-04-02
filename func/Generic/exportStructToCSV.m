function exportStructToCSV( data, filename, append )
%exportStructCSV Exports a struct to text file for use outside matlab
%   Author: Erwin Diepgrond
%   E-mail: e.j.diepgrond@gmail.com
%   decimal seperator is .
%% settings
delimiter = ';'

%% Check input
if ~isstruct(data)
    error('data is not a struct');
end

if nargin == 2
    append = false;
end

if nargin == 1
    append = false;
    filename = uiputfile('*.csv');
end

if isnumeric(filename)
    error('(user canceled operation) Please select a file next time');
end

fileExists = exist(filename,'file') > 0;

if fileExists && ~append
    answer = questdlg('file already exists, you want to overwrite?','file collision','Yes, please', 'No, dont!','No, dont!');
    if strcmp(answer,'No, dont!')
        %error(strcat('Operation exportData(''',filename,''',data) canceled'));
        filename = uiputfile('*.csv');
        if isnumeric(filename)
            error('(user canceled operation) Please select a file next time');
        end
        
    end
end


%% Init data
fields = fieldnames(data); %colomen
n      = length(data);     %rijen

%% Create header
header = '';
for i=1:length(fields)
    if strcmpi(header,'')
        header = fields{i};
    else
        header = strcat(header,delimiter,fields{i});
    end
end

%% Process
try
    if append
        permissions = 'a';
    else
        permissions = 'w+';
    end
    
    hFile = fopen(filename,permissions);
    
    %write header
    if ~append || ~fileExists
        fprintf(hFile,'%s',header);
    end
    for i=1:n
        first = true;
        fprintf(hFile,'\n');
        for  j=1:length(fields)
            %Get data value
            item = eval(strcat('data(',num2str(i),').',fields{j}));
            if first
                fprintf(hFile,'%s',num2str(item)); %num2str works also for string to string
                first = false;
            else
                fprintf(hFile,';%s',num2str(item));
            end
        end
    end
catch e
    fprintf('A error occoured while writing your file:\n%s',e.message);
end
fclose(hFile);
end

