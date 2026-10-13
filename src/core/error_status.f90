! file error_status.f90
! breif project wied status codes and human readable status messages.

! Numerical Lab does not use `error stop` or `stop ` inside reusable
! algotithms, Instead, every algorithm returns a status code from the set
! define here, andn optionally a siagnostic message

module error_status
    use numeric_kinds, only: ik
    implicit none
    private

    integer(ik), parameter, public :: NL_OK = 0

    ! ----------- Input and Algorithm problem --------------------
    ! one or more arfuments were invalid( NaN, wrogn sign, out of range, ...)
    integer(ik), parameter, public :: NL_ERR_INVALID = 1

    ! A logical precondition of the method was violated
    integer(ik), parameter, public :: NL_ERR_DOMAIN = 2

    ! array dimensions are inconsistent or too small for the operation
    integer(ik), parameter, public :: NL_ERR_DIMENSION = 3

    ! Rquared input was numerically unusable
    integer(ik), parameter, public :: NL_ERR_INPUT_NUMERIC = 4

    ! ------------ Algorithm failures   -------------------------
    ! Iretaion did not converge within the allowed maximum
    integer(ik), parameter, public :: NL_ERR_MAXITER = 10

    ! The iteration diverged
    integer(ik), parameter, public :: NL_ERR_DIVERGED = 11

    ! A non finite value appeared during the computation
    integer(ik), parameter, public :: NL_ERR_NONFINITE = 12

    ! A matrix was singular or numerically indistinguishable from singular
    integer(ik), parameter, public :: NL_ERR_SINGULAR = 13

    ! Division by zero
    integer(ik), parameter, public :: NL_ERR_DIV_ZERO = 14

    ! Initial consistency check failed
    integer(ik), parameter, public :: NL_ERR_INTERNAL = 15

    ! ------------     I/O and external resource   ----------------------------
    ! an io fialed
    integer(ik), parameter, public :: NL_ERR_IO = 20


contains
    ! Return a short, human readable description of a status code.

    pure function nl_status_message(code) result(msg)
        integer(ik), intent(in) :: code
        character (len = :), allocatable :: msg

        select case (code)
        case(NL_OK)
            msg = 'OK'
        case(NL_ERR_INVALID)
            msg = "Invalid argument"
        case(NL_ERR_DOMAIN)
            msg = "Method precondition violated"
        case(NL_ERR_DIMENSION)
            msg = "Inconsistent array dimensions"
        case(NL_ERR_INPUT_NUMERIC)
            msg = "Numerically unusable input"
        case(NL_ERR_MAXITER)
            msg = "maximum iteraions reached without convergence"
        case(NL_ERR_DIVERGED)
            msg = "Iteration diverged"
        case(NL_ERR_NONFINITE)
            msg = "non-finite value encountered"
        case(NL_ERR_SINGULAR)
            msg = "matrix is singular or neatly singular"
        case(NL_ERR_DIV_ZERO)
            msg = "devision by zero"
        case(NL_ERR_INTERNAL)
            msg = "internal consistence check failed"
        case(NL_ERR_IO)
            msg = "input/output error"
        case default
            block
                character(len = 32) :: buf
                write(buf, '(I0)') code
                msg = "Unknown status ( " // trim(buf) // " )"
            end block
        end select

    end function nl_status_message
end module error_status