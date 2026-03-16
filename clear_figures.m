fh = findobj(0,'type','figure');
nfh=length(fh); % Total number of open figures, including GUI and figures with visibility 'off'
% Scan through open figures - GUI figure number is [] (i.e. size is zero)
for i = 1:nfh;
    % Close all figures with a Number size is greater than zero
    if strcmpi((fh(i).Name), 'Sparta 2 Synchroniser') == 0;
%         figure(fh(i).Number);
        close(fh(i).Number);
    end;
end;
clear Fig;