function [freeSlots, intScheduled] = createTable(currentTime)
    slots = readmatrix(convertStringsToChars("test/Scheduling/data/output/slotting/"+ string(getlatestfile('test/Scheduling/data/output/slotting/'))));
    slots(:,1) = [];
    slots(:,4) = zeros(length(slots),1);
    slots(slots(:,2)<=16,4) = 1;
    slots(slots(:,2)>=17 & slots(:,2)<=23,4) = 2;
    slots(slots(:,2)>=24,4) = 3;
    Int = load("Interviewers.mat", "Int").Int;
    Can = load("NextRound.mat","Can").Can
    upNext = load("upNext.mat","upNext").upNext;
    limit = min([currentTime+16, 32]);
    freeSlots = Int.Free(:,currentTime+1:limit);
    intScheduled = 0;
    for i = 1:length(slots)
        sID = slots(i,1);
        iID = slots(i,2);
        slot = slots(i,3);
        type = slots(i,4);
        if type == 1
            availableSlots = find(freeSlots(iID,:));
            if (slot-1)*4+1 > length(availableSlots)
            else
               index = availableSlots((slot-1)*4+1);
               if index > 16 && upNext.Scheduled(upNext.ID == sID) == 0

               
               end
               if freeSlots(iID,index) == 1
                    freeSlots(iID,index:index+3) = sID;
                    intScheduled = intScheduled+1;
                    upNext.Scheduled(upNext.ID == sID) = upNext.Scheduled(upNext.ID == sID)+1;
                    Can.nextSlot(Can.ID == sID) = index+currentTime;
                    Can.endSlot(Can.ID == sID) = index+currentTime+3;
               else
                   while true
                        slot = slot+1;
                        if (slot-1)*4+1 > length(availableSlots)
                            break
                        else
                           
                           index = availableSlots((slot-1)*4+1);
                           if freeSlots(iID,index) == 1
                                freeSlots(iID,index:index+3) = sID;
                                intScheduled = intScheduled+1;
                                upNext.Scheduled(upNext.ID == sID) = upNext.Scheduled(upNext.ID == sID)+1;
                                Can.nextSlot(Can.ID == sID) = index+currentTime;
                                Can.endSlot(Can.ID == sID) = index+currentTime+3;
                                break
                           end
                        end

                   end
               end
            end
            
        end
        if type == 2
            availableSlots = find(freeSlots(iID,:));
            if (slot-1)*2+1 > length(availableSlots)
            else 
               index = availableSlots((slot-1)*2+1);
               if freeSlots(iID,index) == 1
                    freeSlots(iID,index:index+1) = sID;
                    intScheduled = intScheduled+1;
                    upNext.Scheduled(upNext.ID == sID) = upNext.Scheduled(upNext.ID == sID)+1;
                    Can.nextSlot(Can.ID == sID) = index+currentTime;
                    Can.endSlot(Can.ID == sID) = index+currentTime+1;
               else
                   while true
                        slot = slot+1;
                        if (slot-1)*2+1 > length(availableSlots)
                            break
                        else
                           
                           index = availableSlots((slot-1)*2+1);
                           if freeSlots(iID,index) == 1
                                freeSlots(iID,index:index+1) = sID;
                                intScheduled = intScheduled+1;
                                upNext.Scheduled(upNext.ID == sID) = upNext.Scheduled(upNext.ID == sID)+1;
                                Can.nextSlot(Can.ID == sID) = index+currentTime;
                                Can.endSlot(Can.ID == sID) = index+currentTime+1;
                                break
                           end
                        end

                   end
               end
            end
            
        end
        if type == 3
            availableSlots = find(freeSlots(iID,:));
            if (slot-1)*1+1 > length(availableSlots)
            else 
               index = availableSlots((slot-1)*1+1);
               if freeSlots(iID,index) == 1
                    freeSlots(iID,index) = sID;
                    intScheduled = intScheduled+1;
                    upNext.Scheduled(upNext.ID == sID) = upNext.Scheduled(upNext.ID == sID)+1;
                    Can.nextSlot(Can.ID == sID) = index+currentTime;
                    Can.endSlot(Can.ID == sID) = index+currentTime;
               else
                    while true
                        slot = slot+1;
                        if (slot-1)*1+1 > length(availableSlots)
                            break
                        else
                           
                           index = availableSlots((slot-1)*1+1);
                           if freeSlots(iID,index) == 1
                                freeSlots(iID,index) = sID;
                                intScheduled = intScheduled+1;
                                upNext.Scheduled(upNext.ID == sID) = upNext.Scheduled(upNext.ID == sID)+1;
                                Can.nextSlot(Can.ID == sID) = index+currentTime;
                                Can.endSlot(Can.ID == sID) = index+currentTime;
                                break
                           end
                        end

                   end
               end

            end
            
        end
        
    end
    Int.Free(:,currentTime+1:limit) = freeSlots;
    save("Interviewers.mat", "Int");
    save("upNext.mat", "upNext");
    save("NextRound.mat","Can")
    updateResults();
    updateStatus(currentTime);
end