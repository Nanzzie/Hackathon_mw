function updateCandidateStatus(ID, status)
    if strcmp(status,'Go') || strcmp(status,'NGo') || strcmp(status,'Meet') ||strcmp(status,'Done')
        if isfile("NextRound.mat")
            Can = load("NextRound.mat","Can").Can;
            Can.Status(Can.ID == ID) = {status};
            save("NextRound.mat","Can")
        else
            Can = load("Candidates.mat","Can").Can;
            Can.Status(Can.ID == ID) = {status};
            save("Candidates.mat","Can")
        end
    end
end