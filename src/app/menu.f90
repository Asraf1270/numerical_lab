module menu
    use input_utils, only: read_integer

    implicit none
    private

    public :: run_main_menu

contains

    subroutine run_main_menu()
        integer :: choice

        do
            call show_main_menu()
            choice = read_integer("Select an option")

            select case (choice)
            case (1)
                call root_finding_menu()
            case (2)
                call linear_systems_menu()
            case (3)
                call integration_menu()
            case (4)
                call error_analysis_menu()
            case (5)
                call show_settings()
            case (0)
                print*
                print*, "Thank you for using Numerical Lab!"
                exit
            case default
                print*, "Invalid option. Try again"
            end select
        end do
    end subroutine run_main_menu

    subroutine show_main_menu()
        print*
        print*, "---------------------------------------"
        print*, "           NUMERICAL LAB               "
        print*, "---------------------------------------"
        print*, " [1] Root Finding Methods"
        print*, " [2] Linear Equations Solver"
        print*, " [3] Numerical Integration"
        print*, " [4] Error Analysis"
        print*, " [5] Settings"
        print*, " [0] Exit"
        print*, "---------------------------------------"

    end subroutine show_main_menu

    subroutine root_finding_menu()
        print*, "Coming soon!"
    end subroutine root_finding_menu

    subroutine linear_systems_menu()
        print*, "Coming soon!"
    end subroutine linear_systems_menu

    subroutine integration_menu()
        print*, "Coming soon!"
    end subroutine integration_menu

    subroutine error_analysis_menu()
        print*, "Coming soon!"
    end subroutine error_analysis_menu

    subroutine show_settings()
        print*
        print*, "----- Settings Menu -----"
        print*, "Default precision: REAL64 (planned)"
        print*, "Tolarance configaration: Coming Soon!"
        print*, "Press Enter to return to the menu"
        read(*, *)
    end subroutine show_settings

    subroutine not_implemented(method_name)
        character(len=*), intent(in) :: method_name

        print*
        print*, trim(method_name)
        print*, "This method will be implemented in a later step."
    end subroutine not_implemented

end module menu