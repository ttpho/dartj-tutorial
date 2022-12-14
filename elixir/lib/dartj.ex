defmodule Dartj do
  @moduledoc """
  Documentation for `Dartj`.
  """

  @doc """
  decode JSON to struct

  ## Examples

      iex -S mix
      iex> Dartj.decode_with_poison()
      [
        %Response{
          address: %Address{
            city: "Gwenborough",
            geo: %Geo{lat: "-37.3159", lng: "81.1496"},
            street: "Kulas Light",
            suite: "Apt. 556",
            zipcode: "92998-3874"
          },
          company: %Company{
            bs: "harness real-time e-markets",
            catch_phrase: nil,
            name: "Romaguera-Crona"
          },
          email: "Sincere@april.biz",
          id: 1,
          name: "Leanne Graham",
          phone: "1-770-736-8031 x56442",
          username: "Bret",
          website: "hildegard.org"
        },
        %Response{
          address: %Address{
            city: "Wisokyburgh",
            geo: %Geo{lat: "-43.9509", lng: "-34.4618"},
            street: "Victor Plains",
            suite: "Suite 879",
            zipcode: "90566-7771"
          },
          company: %Company{
            bs: "synergize scalable supply-chains",
            catch_phrase: nil,
            name: "Deckow-Crist"
          },
          email: "Shanna@melissa.tv",
          id: 2,
          name: "Ervin Howell",
          phone: "010-692-6593 x09125",
          username: "Antonette",
          website: "anastasia.net"
        }
      ]
  """
  def decode_with_poison do
    json =
      ~s([{"id":1,"name":"Leanne Graham","username":"Bret","email":"Sincere@april.biz","address":{"street":"Kulas Light","suite":"Apt. 556","city":"Gwenborough","zipcode":"92998-3874","geo":{"lat":"-37.3159","lng":"81.1496"}},"phone":"1-770-736-8031 x56442","website":"hildegard.org","company":{"name":"Romaguera-Crona","catchPhrase":"Multi-layered client-server neural-net","bs":"harness real-time e-markets"}},{"id":2,"name":"Ervin Howell","username":"Antonette","email":"Shanna@melissa.tv","address":{"street":"Victor Plains","suite":"Suite 879","city":"Wisokyburgh","zipcode":"90566-7771","geo":{"lat":"-43.9509","lng":"-34.4618"}},"phone":"010-692-6593 x09125","website":"anastasia.net","company":{"name":"Deckow-Crist","catchPhrase":"Proactive didactic contingency","bs":"synergize scalable supply-chains"}}])

    Poison.decode!(json, as: [%Response{address: %Address{geo: %Geo{}}, company: %Company{}}])
  end


  # Dartj.decode_with_jason()
  def decode_with_jason do
    json =
      ~s([{"id":1,"name":"Leanne Graham","username":"Bret","email":"Sincere@april.biz","address":{"street":"Kulas Light","suite":"Apt. 556","city":"Gwenborough","zipcode":"92998-3874","geo":{"lat":"-37.3159","lng":"81.1496"}},"phone":"1-770-736-8031 x56442","website":"hildegard.org","company":{"name":"Romaguera-Crona","catchPhrase":"Multi-layered client-server neural-net","bs":"harness real-time e-markets"}},{"id":2,"name":"Ervin Howell","username":"Antonette","email":"Shanna@melissa.tv","address":{"street":"Victor Plains","suite":"Suite 879","city":"Wisokyburgh","zipcode":"90566-7771","geo":{"lat":"-43.9509","lng":"-34.4618"}},"phone":"010-692-6593 x09125","website":"anastasia.net","company":{"name":"Deckow-Crist","catchPhrase":"Proactive didactic contingency","bs":"synergize scalable supply-chains"}}])

    json |> Jason.decode!() |> to_srtuct(nil)
  end

  def to_srtuct(json, module) when is_list(json) do
    json 
    |> Enum.map(fn item -> to_srtuct(item, module) end)
  end

  def to_srtuct(map, module) when is_map(map) and is_nil(module) do
    map_with_atom_keys =
      for {key, val} <- map, into: %{} do
        {String.to_atom(key), to_srtuct(val, String.to_atom(key))}
      end
    moduleName = case module do
      nil -> Response
      :address -> Address
      :geo -> Geo
      :company -> Company
      _ -> nil
    end

    struct(moduleName, map_with_atom_keys)
  end


  def to_srtuct(map, _module) do
    map
  end 
end
