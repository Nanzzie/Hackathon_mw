function updateResults
    Can = load("NextRound.mat","Can").Can;
    for i = 1:length(Can.Status)
        if strcmp('Go',cell2mat(Can.Status(i)))
            x=rand;
            if x<0.75
              Can.Status(i) = {'Go'};
            else
              Can.Status(i) = {'NGo'};
            end
        end

    end
    save("NextRound.mat","Can")
end