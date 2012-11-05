CREATE TABLE IF NOT EXISTS players (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR NOT NULL,
    twitter VARCHAR NOT NULL UNIQUE,
    password VARCHAR NOT NULL,
    created_at DEFAULT current_timestamp,
    updated_at DEFAULT current_timestamp
);

CREATE TABLE IF NOT EXISTS games (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    player1 INTEGER NOT NULL,
    player2 INTEGER NOT NULL,
    winner INTEGER,
    created_at DEFAULT current_timestamp,
    updated_at DEFAULT current_timestamp,
    FOREIGN KEY (player1) REFERENCES Players(id),
    FOREIGN KEY (player2) REFERENCES Players(id)
);