module input_utils
    implicit none
    private

    public :: read_integer

contains

    integer function read_integer(prompt) result(value)
        character(len =*), intent(in) :: prompt
        character (len=100) :: line
        integer :: ios

        do
            write(*, '(A)', advance = 'no') trim(prompt)
            read(*, '(A)') line

            read(line, *, iostat = ios) value

            if (ios == 0) return

            print*, "Invalid input. please enter an integer"
        end do

    end function read_integer

end module input_utils