#***************************************************************************************************************
#** Common-Functions.psm1
#***************************************************************************************************************

#***********************************************************************************************************
#** Is a number prime or composite?
#***********************************************************************************************************

function IsPrime([int]$v)
{
    if($v -gt 2)
    {
        if(($v % 2) -eq 0)
        {
            return $false
        }
        else
        {        
            for($i = 2; $i -lt $v; $i++)
            {
                if(($v % $i) -eq 0)
                {
                    return $false
                }
            }
        }
    }
    return $true
}

#***********************************************************************************************************
#** Given a prime find the next one
#***********************************************************************************************************

function NextPrime([int]$last)
{
	$i = ($last+1)
	while($true)
	{
		if(IsPrime($i))
		{
			return $i	
			break
		}
        
        $i++
	}
}

#***********************************************************************************************************
#** Is the integer a palindrome
#***********************************************************************************************************

function IsPalindrome([int]$value)
{
	$str = $value.ToString()
	$len = $str.Length
	$index = 1;
	
	while(($index - 1) -le ($len-$index))
	{
		if($str[$index - 1] -ne $str[$len-$index])
		{
			return $false
		}
        
        $index++
	}
	
	return $true
}

#***********************************************************************************************************
#** Get the prime factors
#***********************************************************************************************************

function PrimeFactors([int]$compositevalue)
{
	$prime = 1
	$divisors = @(1)
	while($compositevalue -ne 1)
	{
		$prime = NextPrime($prime)
		$rem = $compositevalue % $prime
		if($rem -eq 0)
		{
			$compositevalue = $compositevalue / $prime
			$divisors += $prime
			$prime = 1
		}
	}
	return $divisors
}

#***************************************************************************************************************
#** Exports
#***************************************************************************************************************

#export-modulemember -function IsPrime
#export-modulemember -function NextPrime
#export-modulemember -function IsPalindrome
#export-modulemember -function PrimeFactors

#***************************************************************************************************************