defmodule Response do
    @moduledoc """
      mix phx.gen.context YourDomain Response response \
          id:bigint \
          name:text \
          username:text \
          email:text \
          address:map \
          phone:text \
          website:text \
          company:map
    """
  
    @derive [Poison.Encoder]
    defstruct [:id, :name, :username, :email, :address, :phone, :website, :company]
  end
  
  
  defmodule Address do
    @moduledoc """
      mix phx.gen.context YourDomain Address address \
          street:text \
          suite:text \
          city:text \
          zipcode:text \
          geo:map
    """
  
    @derive [Poison.Encoder]
    defstruct [:street, :suite, :city, :zipcode, :geo]
  end
  
  
  defmodule Geo do
    @moduledoc """
      mix phx.gen.context YourDomain Geo geo \
          lat:text \
          lng:text
    """
  
    @derive [Poison.Encoder]
    defstruct [:lat, :lng]
  end
  
  
  defmodule Company do
    @moduledoc """
      mix phx.gen.context YourDomain Company company \
          name:text \
          catch_phrase:text \
          bs:text
    """
  
    @derive [Poison.Encoder]
    defstruct [:name, :catch_phrase, :bs]
  end