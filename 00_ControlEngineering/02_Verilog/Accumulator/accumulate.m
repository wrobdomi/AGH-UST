A = [ 1 2 3 1.5 1.6 1.7 1.8 1.9 0.5 0.2 ];
A = sfi((1*A),13,4);     % Input data
y = sfi(zeros(size(A)),21,4);      % Initialize Output data
acc = sfi(0,21,4); % Reset accumulator
acc_states = [acc];
    for k = 1:length(A)
        acc = accumpos(acc,A(k)); % uses result size of acc to add acc and A
        acc_states = [ acc_states acc ] ;
    end
    y = acc;            % Assign output