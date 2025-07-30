module "alb" {
    source = "./modules/alb"
    name = "ecs-alb"
    public_subnets = module.vpc.public_subnet_ids
    vpc_id = module.vpc.vpc_id
    alb_sg_id = module.sg.alb_sg_id
}

module "ecr" {
    source = "./modules/ecr"
    ecr_repo_name = var.ecr_repo_name
}

module "vpc" {
    source = "./modules/vpc"
    vpc_name = var.vpc_name
    vpc_cidr = var.vpc_cidr
    public_subnets = var.public_subnets
    private_subnets = var.private_subnets
    azs = var.azs
}



module "ecs" {
    source = "./modules/ecs"
    cluster_name = var.cluster_name
    subnet_ids = module.vpc.private_subnet_ids
    security_groups = [module.sg.ecs_sg_id]
    task_arn_role = var.execution_role_arn
    execution_role_arn = var.execution_role_arn
    ecs_target_group_arn = module.alb.appointments_target_group_arn

    services = {
        appointment-service = {
            image = module.ecr.repositories["node-appointment"]
            cpu = 256
            memory = 512
            container_port = 80
            target_group_arn = module.alb.appointments_target_group_arn
        }
        patient-service = {
            image = module.ecr.repositories["node-patient"]
            cpu = 256
            memory = 512
            container_port = 80
            target_group_arn = module.alb.patients_target_group_arn
        }

    }
}

module "sg" {
    source = "./modules/sg"
    vpc_id = module.vpc.vpc_id
    alb_sg_name = var.alb_sg_name
    ecs_sg_name = var.ecs_sg_name
  
}