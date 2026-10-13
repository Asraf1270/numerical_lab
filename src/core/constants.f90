! file constant.f90
! breif mathematical and numerical contants user project wide
module constants
    use numeric_kinds, only: wp
    implicit none
    private

    ! Pi to full binary precision 
    real(wp), parameter, public :: NL_PI = 3.14159265358979323846264338327950288_wp

    ! FOR E
    real(wp), parameter, public :: NL_E = 2.71828182845904523536028747135266250_wp

    ! machine epsilon for the workind precision
    real(wp), parameter, public :: NL_EPS = epsilon(1.0_wp)

    ! smallest positive number for wp
    real(wp), parameter, public :: NL_TINY = tiny(1.0_wp)

    !LArgest finite number for the wp
    real(wp), parameter, public :: NL_HUGE = huge(1.0_wp)

    !Default absolute tolarance 
    real(wp), parameter, public :: NL_DEF_ATOL = 1.0e-10_wp

    ! default relatice tolarance
    real(wp), parameter, public :: NL_DEF_RTOL = 1.0e-10_wp

    ! Default maximum number of iteration for iterative methods
    integer, parameter, public :: NL_DEF_MAXITER = 100

end module constants