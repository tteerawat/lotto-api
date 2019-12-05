defmodule LottoAPI.Numbers do
  defmodule Helpers do
    def sort_number(number_str) do
      number_str
      |> String.split("", trim: true)
      |> Enum.sort()
      |> Enum.join()
    end
  end

  @one_digit_numbers Enum.map(0..9, &to_string/1)

  @two_digits_numbers Enum.flat_map(@one_digit_numbers, fn i ->
                        Enum.map(@one_digit_numbers, fn j ->
                          i <> j
                        end)
                      end)

  @three_digits_numbers Enum.flat_map(@one_digit_numbers, fn i ->
                          Enum.flat_map(@one_digit_numbers, fn j ->
                            Enum.map(@one_digit_numbers, fn k ->
                              i <> j <> k
                            end)
                          end)
                        end)

  @unique_three_digits_numbers @three_digits_numbers
                               |> Enum.map(&Helpers.sort_number/1)
                               |> Enum.uniq()

  def list_two_digits_numbers do
    @two_digits_numbers
  end

  def list_three_digits_numbers do
    @three_digits_numbers
  end

  def list_numbers_from_order_type("up_two"), do: @two_digits_numbers
  def list_numbers_from_order_type("down_two"), do: @two_digits_numbers
  def list_numbers_from_order_type("up_three"), do: @three_digits_numbers
  def list_numbers_from_order_type("shuffle_three"), do: @unique_three_digits_numbers
end
