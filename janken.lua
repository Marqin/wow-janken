SLASH_JANKEN1 = '/janken';
function SlashCmdList.JANKEN(msg, editBox)
  janken_SlashCommand();
end

local function makejenkenFriendList()
  local f = CreateFrame("Frame", "jenkenFriendList", UIParent)
  f:Hide()
  tinsert(UISpecialFrames, f:GetName())
  f:SetSize(150, 200)
  f:SetPoint("CENTER")
  local t = f:CreateTexture()
  t:SetAllPoints()
  t:SetTexture(1, 1, 1, 1)
  f.background = t
  return f
end

local friendButtons = {}
local friendFrame = makejenkenFriendList()

local function cleanFrame()
  friendFrame:Hide()
  for _, b in ipairs({friendFrame:GetChildren()}) do
    b:Hide()
    tinsert(friendButtons, b)
  end
end

local function getButton(text)
  local b = tremove(friendButtons)
  if not b then
    b = CreateFrame("Button", text, friendFrame, "UIPanelButtonTemplate")
  end

  b:SetText(text)
  b:SetSize(b:GetTextWidth(), b:GetTextHeight())

  b:Show()

  return b
end

function janken_SlashCommand()
  local friends = janken_getBNFriends();
  local i = 0
  for name, id in pairs(friends) do

    local b = getButton(name)
    b:SetPoint("TOPLEFT", 0, -1*i*(b:GetTextHeight()+5))
    b:SetScript("OnClick", function()
      cleanFrame()
      janken_inviteToPlay(name, id)
    end)
    i = i+1

  end

  local b = getButton("Cancel")
  b:SetPoint("TOPLEFT", 0, -1*i*(b:GetTextHeight()+5) - 20)
  b:SetScript("OnClick", cleanFrame)

  friendFrame:Show()
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

function janken_inviteToPlay(name, id)
  print("Inviting " .. name .. "(" .. id .. ") to play Janken.")
end
