defmodule Wabanex.UserTest do
  use  Wabanex.DataCase, async: true

  describe "changeset/1" do
    test "when all params arer valid, returns a valid changeset" do
      params = %{name: "Pablo", email: "pablo@gmail.com", password: "123456"}

      alias Wabanex.User

      response = User.changeset(params)

      assert %Ecto.Changeset{valid?: true, changes: %{name: "Pablo", email: "pablo@gmail.com", password: "123456"}, errors: []} = response
    end

    test "when there are invalid params, returns a invalid changeset" do
      params = %{name: "P", email: "pablo@gmail.com"}

      alias Wabanex.User

      response = User.changeset(params)

      expected_response = %{name: ["should be at least 2 character(s)"], password: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end
end
