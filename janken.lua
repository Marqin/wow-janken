SLASH_JANKEN1 = '/janken';
function SlashCmdList.JANKEN(msg, editBox)
  janken_SlashCommand();
end

function janken_SlashCommand()
  local friends = janken_getBNFriends();
  for name in pairs(friends) do
    print(name)
  end
end

function janken_getBNFriends()
  local totalBNet = BNGetNumFriends()
  local friends = {}
  for i = 1, totalBNet do
    local presenceID, presenceName = BNGetFriendInfo(i)
    friends[presenceName] = presenceID
  end
  return friends
end
