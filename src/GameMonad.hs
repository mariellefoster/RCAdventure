module GameMonad
    ( GameMonad, Room, showRoomDescription, seeAdjacentRooms, initRoom, getRoom, makeRoom
    ) where


-- TODO : Add name
              -- current room
data GameMonad room = CurrentRoom room deriving(Show, Eq)

       -- name description adjacent-rooms   *need options
--data Room = String String [Room]
data Room = Kitchen | McCarthy | Library | MainSpace deriving(Show, Eq)

instance Monad GameMonad where
    return room = (CurrentRoom room) --makes a gamemonad
    (CurrentRoom room) >>= f = f room

instance Functor GameMonad where
    fmap f (CurrentRoom room) = (CurrentRoom $ f room)

instance Applicative GameMonad where
    pure = return
    (CurrentRoom f) <*> (CurrentRoom room) = (CurrentRoom $ f room)

getRoom :: GameMonad r -> r
getRoom (CurrentRoom room) = room

showRoomDescription :: Room -> String
showRoomDescription Kitchen = "Where everything begins. We eat things here"
showRoomDescription McCarthy = "there are couches here"
showRoomDescription Library = "there are couches here, and also books. sometimes Ginger if you are lucky"
showRoomDescription MainSpace = "A french cafe style arrangement of tables and chairs (chaises), surrounded by many Recursers and their electronic devices"

seeAdjacentRooms :: Room -> [Room]
seeAdjacentRooms Kitchen = [MainSpace] 
seeAdjacentRooms McCarthy = [MainSpace]
seeAdjacentRooms Library = [MainSpace]
seeAdjacentRooms MainSpace = [Kitchen, McCarthy, Library]

makeRoom :: String -> Room
makeRoom "Kitchen" = Kitchen
makeRoom "McCarthy" = McCarthy
makeRoom "Library" = Library
makeRoom "MainSpace" = MainSpace

initRoom :: GameMonad Room
initRoom = CurrentRoom Kitchen


