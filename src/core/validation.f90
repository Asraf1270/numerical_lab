! file validation.f90
! breif pure input-validation predicates shared by all Numerical Lab algorithm

! This module collects those cecks in one place so that:
! - Every algorithm validates its own inputs at the boundary, suing the same rules.
! - The CLI can pre-check user input and give a friendly message before calling an algorithm that would just fail.
! - Tests can exercise the predicates directly, without needing to construct a numerical experiment.

module validation
    use numeric_kinds, only: wp, ik
    use constants, only: NL_TINY, NL_EPS, NL_DEF_ATOL, NL_DEF_RTOL
    implicit none
    private

    public :: is_finite_wp
    public :: all_finite
    ! public :: iterval_valid
    ! public :: breckets_root
    ! public :: nsub_valid_for_simpson13
    ! public :: nsub_valid_for_simpson38
    ! public :: nsub_valid_for_trapezoid
    ! public :: matrix_dims_ok
    ! public :: vector_len_ok
    ! public :: is_nearly_singular
    ! public :: nonzero_step
    ! public :: tol_pair_valid


    !-------------------------------------------------
    ! Scalar finiteness
    !-------------------------------------------------

contains

    ! True if x is neither NaN not Inf
    pure logical function is_finite_wp(x) result(ok)
        real(wp), intent(in) :: x
        ok = ieee_is_finite_safe(x)
    end function is_finite_wp


    ! True if every element of v is finite
    pure logical function all_finite(v) result(ok)
        real(wp), intent(in) :: v(:)
        integer :: i 
        ok = .true.
        do i = 1, size(v)
            if (.not. is_finite_wp(v(i))) then
                ok = .false.
                return
            end if
        end do
    end function all_finite




    ! ----------------------------------------------------
    ! Internal helper
    ! ----------------------------------------------------

    pure logical function ieee_is_finite_safe(x) result(ok)
        use, intrinsic :: ieee_arithmetic, only: ieee_is_finite 
        real(wp), intent(in) :: x
        ok = ieee_is_finite(x)
    end function ieee_is_finite_safe

end module validation