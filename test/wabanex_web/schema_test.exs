defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{name: "Pablo", email: "pablo@gmail.com", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}"){
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response =  %{"data" => %{"getUser" => %{"email" => "pablo@gmail.com", "name" => "Pablo"}}}

      assert response === expected_response
    end
  end

  describe "users mutations" do
    test "when all params are valid, creates the user", %{conn: conn} do

      mutation = """
        mutation {
          createUser(input: {
            name:"Pablo"
            email:"pablo@gmail.com"
            password:"1234567"
          })
          {
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"email" => "pablo@gmail.com", "id" => _id, "name" => "Pablo"}}} = response
    end
  end
end
