--+---------------+--
--| No dependency |--
--+---------------+--
require "levels.wall"

--+-----------------+--
--| Depends on wall |--
--+-----------------+--
require "levels.room"

--+-----------------+--
--| Depends on room |--
--+-----------------+--
require "levels.level"

--+------------------+--
--| Depends on level |--
--+------------------+--
require "levels.levelHandler"
