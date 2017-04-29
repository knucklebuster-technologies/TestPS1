TestScript 'Test The Tester' {
    Write-Verbose -Message 'Testing The Tester'
    
    SETUP {
        Write-Verbose -Message 'Testing The SETUP'   
    }

    SETUP {
        $true
    }

    SETUP {
        'false'
    }

    SETUP {
        $false
    }

    SETUP {
        throw 'Should Fail'
    }

    SETUP {
        Write-Error -Message 'Should Fail'
    }
    
    STEP 'Test Step' {
        Write-Verbose -Message 'Testing The STEP'
    } 

    STEP 'Test Step' {
        $true
    }

    STEP 'Test Step' {
        'false'
    }

    STEP 'Test Step' {
        $false
    }

    STEP 'Test Step' {
        throw 'Should Fail'
    }

    STEP 'Test Step' {
        Write-Error -Message 'Should Fail'
    }

} -Verbose