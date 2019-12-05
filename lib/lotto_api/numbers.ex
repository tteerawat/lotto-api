defmodule LottoAPI.Numbers do
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

  def list_two_digits_numbers do
    @two_digits_numbers
  end

  def list_three_digits_numbers do
    @three_digits_numbers
  end
end
