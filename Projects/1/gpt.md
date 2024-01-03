# Valorant XML Data Structure

## `<valorant_state>`
The root element containing all Valorant-related information.

## `<ranks>`
Information about player ranks, including names, divisions, images, and player base percentages.

### `<rank>`
Each rank has the following attributes:
- `<rank_name>`: Name of the rank (e.g., "Immortal" and "Radiant").
- `<divisions>`: List of divisions for that rank.
- `<image>`: Image source for the rank.
- `<playerbase_percent>`: The percentage of the player base in this rank.

## `<teams>`
Information about Valorant teams and their players.

### `<team>`
Details about a specific team:
- `<name>`: Team name (e.g., "Team 1").
- `<players>`: Information about the players in the team.

### `<player>`
Information about a player within a team:
- `<username>`: Player's username with a game tag.
- `<rank>`: Player's rank with a division.
- `<server>`: Server information, including average ping.
- `<personal_info>`: Sensitive personal information about the player.
  
  #### Personal Information
  - `<fullname>`: Player's full name.
  - `<age>`: Player's age.
  - `<country>`: Player's country.
  - `<socials>`: Links to the player's social media profiles.
  
  #### Favorite Equipment
  - `<weapon>`: Favorite weapon details.
    - `<name>`: The weapon's name.
    - `<skin>`: Information about the weapon's skin.
  - `<agent>`: Favorite agent.
  - `<mouse>`: Information about the player's mouse.
  - `<keyboard>`: Information about the player's keyboard.
  - `<monitor>`: Information about the player's monitor.

## `<tournaments>`
Information about Valorant tournaments.

### `<tournament>`
Details about a specific tournament:
- `<name>`: The name of the tournament.
- `<location>`: The location where the tournament took place.
- `<date>`: The date of the tournament.
- `<prize_pool>`: Information about the tournament's prize pool, including currency.
- `<teams>`: List of teams participating in the tournament.