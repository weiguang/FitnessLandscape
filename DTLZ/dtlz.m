function f = dtlz(x,func_num)
%DTLZ �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
M =4; % Number of objective
f = feval(['dtlz',num2str(func_num)],x, M);
end
