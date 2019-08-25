# Server

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# Endpoints

## [POST]/source/exec

Request payload
```
{
  "source": "YOUR_SOURCE_CODE_HERE"
  "language": "go|elixir|node|python"
}
```