-- ============================================
-- 1. PLAYERS - People who play games
-- ============================================
CREATE TABLE players (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    country VARCHAR(50),
    join_date DATE,
    total_spent DECIMAL(10,2) DEFAULT 0.00,
    status ENUM('Active', 'Inactive', 'Banned') DEFAULT 'Active'
);


-- ============================================
-- 2. GAMES - Different games in the platform
-- ============================================
CREATE TABLE games (
    game_id INT PRIMARY KEY AUTO_INCREMENT,
    game_name VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    release_date DATE,
    price DECIMAL(10,2),
    developer VARCHAR(100),
    avg_rating DECIMAL(3,2)
);

-- ============================================
-- 3. PLAYER_GAMES - Which players own which games
-- ============================================
CREATE TABLE player_games (
    player_game_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    game_id INT,
    purchase_date DATE,
    purchase_price DECIMAL(10,2),
    hours_played DECIMAL(10,2) DEFAULT 0,
    last_played DATE,
    FOREIGN KEY (player_id) REFERENCES players(player_id),
    FOREIGN KEY (game_id) REFERENCES games(game_id),
    UNIQUE(player_id, game_id)  -- A player can own a game only once
);

-- ============================================
-- 4. ACHIEVEMENTS - In-game achievements/trophies
-- ============================================
CREATE TABLE achievements (
    achievement_id INT PRIMARY KEY AUTO_INCREMENT,
    game_id INT,
    achievement_name VARCHAR(100),
    description TEXT,
    rarity ENUM('Common', 'Rare', 'Epic', 'Legendary'),
    points INT,
    FOREIGN KEY (game_id) REFERENCES games(game_id)
);

-- ============================================
-- 5. PLAYER_ACHIEVEMENTS - Achievements unlocked by players
-- ============================================
CREATE TABLE player_achievements (
    player_achievement_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    achievement_id INT,
    unlocked_date DATE,
    FOREIGN KEY (player_id) REFERENCES players(player_id),
    FOREIGN KEY (achievement_id) REFERENCES achievements(achievement_id),
    UNIQUE(player_id, achievement_id)  -- Can't unlock same achievement twice
);

-- ============================================
-- 6. IN_GAME_PURCHASES - Microtransactions
-- ============================================
CREATE TABLE in_game_purchases (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    game_id INT,
    item_name VARCHAR(100),
    purchase_date DATE,
    amount DECIMAL(10,2),
    currency VARCHAR(10),
    FOREIGN KEY (player_id) REFERENCES players(player_id),
    FOREIGN KEY (game_id) REFERENCES games(game_id)
);

-- ============================================
-- 7. FRIENDS - Player friendships
-- ============================================
CREATE TABLE friends (
    friendship_id INT PRIMARY KEY AUTO_INCREMENT,
    player1_id INT,
    player2_id INT,
    friend_since DATE,
    status ENUM('Friends', 'Pending', 'Blocked') DEFAULT 'Friends',
    FOREIGN KEY (player1_id) REFERENCES players(player_id),
    FOREIGN KEY (player2_id) REFERENCES players(player_id),
    CHECK (player1_id < player2_id)  -- Prevents duplicate friendships (1-2 and 2-1)
);
