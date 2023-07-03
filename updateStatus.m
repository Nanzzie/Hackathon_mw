function updateStatus(currentTime)
    Int = load("Interviewers.mat", "Int").Int;
    Can = load("NextRound.mat", "Can").Can;
    Result = load("Results.mat","Result").Result;
    for i = 1:height(Int)
        if Int.Free(i,currentTime) ~= 0 && Int.Free(i,currentTime) ~= 1
            if strcmp(cell2mat(Can.Status(Int.Free(i,currentTime))),'Go')
                Can.Status(Int.Free(i,currentTime)) = 'Meet';
            end
        end
    end

    for i = 1:height(Can)
        if strcmp(cell2mat(Can.Status(i)),'NGo') == 1
            continue
        end
        
        if currentTime >= Can.nextSlot(i) && currentTime <= Can.endSlot(i)
            Can.Status(i) = 'Meet';
        elseif currentTime > Can.endSlot(i)
            Can.Status(i) = Result(i);
        end
    end

end