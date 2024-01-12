# parameters of script
[CmdletBinding()]
param (
    [Parameter()]
    [hashtable]
    $TrainingParams = 
    @{
        model      = "yolov5altek"
        dataset    = "wood_pallet"
        hyp_name   = "altek"
        env_name   = "yolov5"
        proj_name  = "test2"
        weights    = "D:\billy\repo\yolov5\runs\test1\yolov5altek-wood_pallet-20240111-altek\weights\best.pt"
        epochs     = 600
        imgsz      = 640
        batch_size = 64
        evolve     = 0
        workers    = 8
    }
)

# function 
function RunPython ([hashtable]$params) 
{
    # set root folder of yolov5
    $root = "D:\billy\repo\yolov5\"

    # set path of python file that train model
    $py_file = $root + "train.py"

    # set date
    $date = Get-Date -Format "yyyyMMdd"

    # set params
    $params["cfg"]     = $($root + "models\" + $params["model"] + ".yaml")
    $params["data"]    = $($root + "data\" + $params["dataset"] + ".yaml")
    $params["hyp"]     = $($root + "data\hyps\hyp." + $params["hyp_name"] + ".yaml")
    $params["project"] = $($root + "runs\" + $params["proj_name"])
    $params["name"]    = $($params["model"] + "-" + $params["dataset"] + "-" + $date + "-" + $params["hyp_name"])
    $params["best"]    = $($params["project"] + "\" + $params["name"] + "\weights\best.pt")
    
    # run python
    python $py_file `
        --weights    $params["weights"] `
        --cfg        $params["cfg"] `
        --data       $params["data"] `
        --hyp        $params["hyp"] `
        --epochs     $params["epochs"] `
        --imgsz      $params["imgsz"] `
        --batch-size $params["batch_size"] `
        --evolve     $params["evolve"] `
        --workers    $params["workers"] `
        --project    $params["project"] `
        --name       $params["name"] `
        --exist-ok `
        # --resume     $($params["project"] + "\yolov5altek-wood_pallet-20240111-altek\weights\last.pt")
        # --rect `
        # --no-overlap `
        
    # check best.pt of model
    $weights_exist = Test-Path -Path $TrainingParams["best"] -PathType Leaf
    if (-not $weights_exist) 
    {
        Write-Warning $("[" + $TrainingParams["best"]+"] is not exist.")
        return $false    
    }

    return $true
}

# main
function main 
{
    # set environment
    conda activate $TrainingParams["env_name"]

    # run function
    $return = RunPython -params $TrainingParams

    return  $return
}

# return
return main