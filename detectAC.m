function I=detectAC(index)
I=0;
    for i=2:length(index)
        if index(i)-index(i-1)~=1
            I=i-1;
            break
        end
    end
end
